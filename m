Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314444AbSDVTT3>; Mon, 22 Apr 2002 15:19:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314456AbSDVTT2>; Mon, 22 Apr 2002 15:19:28 -0400
Received: from cerebus.wirex.com ([65.102.14.138]:23543 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id <S314444AbSDVTT1>; Mon, 22 Apr 2002 15:19:27 -0400
Date: Mon, 22 Apr 2002 12:18:19 -0700
From: Chris Wright <chris@wirex.com>
To: Florian Weimer <Weimer@CERT.Uni-Stuttgart.DE>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [SECURITY] FDs 0, 1, 2 for SUID/SGID programs
Message-ID: <20020422121819.A13864@figure1.int.wirex.com>
Mail-Followup-To: Florian Weimer <Weimer@CERT.Uni-Stuttgart.DE>,
	linux-kernel@vger.kernel.org
In-Reply-To: <87662jiz3b.fsf@CERT.Uni-Stuttgart.DE>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Florian Weimer (Weimer@CERT.Uni-Stuttgart.DE) wrote:
> http://www.pine.nl/advisories/pine-cert-20020401.html probably affects
> Linux, too (if a SUID/SGID program is invoked with FD 2 closed, error
> messages might be written to a file opened by the program ).

AFAIK, the standards clearly specify behaviour wrt. open file descriptors
and clone-on-exec file descriptors across execve().  However, there
is nothing specified when it comes to closed file descpriptors across
execve(), notably FD's 0, 1 and 2 are certainly not required to be open
across an execve() of a SUID/SGID applictaion.  One could argue that
SUID/SGID apps that trust the file descriptors they inherit across exec()
are buggy.

Having said that, there are a number of implementations of this type
of protection for the linux kernel stemming from the Openwall project.
If you are interested, see:

	http://www.openwall.com	(CONFIG_SECURE_FD_0_1_2)
	http://lsm.immunix.org	(CONFIG_OWLSM_FD)
	http://grsecurity.net	(CONFIG_GRKERNSEC_FD)

cheers,
-chris
