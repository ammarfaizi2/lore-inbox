Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269582AbUJLJmq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269582AbUJLJmq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 05:42:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269581AbUJLJmq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 05:42:46 -0400
Received: from cimice4.lam.cz ([212.71.168.94]:64654 "EHLO vagabond.light.src")
	by vger.kernel.org with ESMTP id S269583AbUJLJly (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 05:41:54 -0400
Date: Tue, 12 Oct 2004 11:41:04 +0200
From: Jan Hudec <bulb@ucw.cz>
To: suthambhara nagaraj <suthambhara@gmail.com>
Cc: "Dhiman, Gaurav" <gaurav.dhiman@ca.com>,
       main kernel <linux-kernel@vger.kernel.org>,
       kernel <kernelnewbies@nl.linux.org>
Subject: Re: Kernel stack
Message-ID: <20041012094104.GM703@vagabond>
References: <577528CFDFEFA643B3324B88812B57FE3055B9@inhyms21.ca.com> <46561a790410112351942e735@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sMkrXc3gAYLRVOjR"
Content-Disposition: inline
In-Reply-To: <46561a790410112351942e735@mail.gmail.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--sMkrXc3gAYLRVOjR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 12, 2004 at 12:21:37 +0530, suthambhara nagaraj wrote:
> Hi,
> The problem is each process does not have a TSS of its own.Only one
> TSSper processor is present and the process dependant features (Like
> esp) are stored
> in another structure( struct thread_struct ).A kernel stack of size 8k
> (By default)
> is actully shared by processes running on a processor. There is a func named
> load_tss (or something similiar) which loads the TSS from the
> thread_struct structure during task switch .

Yes. Thus each process has it's own TSS. It is just stored differently
when the process is not scheduled.

It comes out of that, that the stack is NOT shared among different
processes, because it is replaced whenever a different process is
scheduled on a CPU.

> A Process does not have an SS entry in its thread_struct but only an
> esp (and esp0) entry. This made me believe that the stack base is the
> same.

There is no SS entry, because SS does not specify the stack. It is siply
a segment in which the stack lives. Any segment, that covers all address
space will do! IIRC in kernel SS == DS.

The base of the stack does not have to be stored either, because it is
AT FIXED OFFSET from the task_struct! If you don't believe me, look at
definition of the current macro. It says just (%esp & ~8195) (it says it
in assembly, because you can't directly access registers from C, and it
uses some macros that mean "two pages" instead of 8195).

The kernel stack is allocated together with the task_struct. Two pages
are allocated and task_struct is placed at the start while the stack is
placed at the end and grows down towards the task_struct.

-------------------------------------------------------------------------------
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--sMkrXc3gAYLRVOjR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBa6awRel1vVwhjGURAtsLAKDpgUEafYkpggmimvz/JhLD+xzVbQCfXoQh
iCWaA24oRgSG7PtEa63RCi8=
=BRBd
-----END PGP SIGNATURE-----

--sMkrXc3gAYLRVOjR--
