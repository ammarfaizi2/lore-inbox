Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932109AbWDXXgf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932109AbWDXXgf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 19:36:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932106AbWDXXgf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 19:36:35 -0400
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:51980 "EHLO
	mail.esperi.org.uk") by vger.kernel.org with ESMTP id S1751271AbWDXXge
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 19:36:34 -0400
To: Arjan van de Ven <arjan@infradead.org>
Cc: "Makan Pourzandi (QB/EMC)" <makan.pourzandi@ericsson.com>,
       linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
       Serue Hallyen <serue@us.ibm.com>,
       Axelle Apvrille <axelle_apvrille@rc1.vip.ukl.yahoo.com>,
       disec-devel@lists.sourceforge.net
Subject: Re: [ANNOUNCE] Release Digsig 1.5: kernel module for run-timeauthentication of binaries
References: <6D19CA8D71C89C43A057926FE0D4ADAA29D361@ecamlmw720.eamcs.ericsson.se>
	<1145897277.3116.44.camel@laptopd505.fenrus.org>
	<87hd4ipvdk.fsf@hades.wkstn.nix>
	<1145911526.3116.71.camel@laptopd505.fenrus.org>
From: Nix <nix@esperi.org.uk>
X-Emacs: you'll understand when you're older, dear.
Date: Tue, 25 Apr 2006 00:35:53 +0100
In-Reply-To: <1145911526.3116.71.camel@laptopd505.fenrus.org> (Arjan van de Ven's message of "Mon, 24 Apr 2006 22:45:26 +0200")
Message-ID: <87zmiao8bq.fsf@hades.wkstn.nix>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Apr 2006, Arjan van de Ven yowled:
> On Mon, 2006-04-24 at 21:32 +0100, Nix wrote:
>> It checks mmap and mprotect with PROT_EXEC, and execve().
> 
> so no jvm's or flash plugins.

Well, you'll have to sign the flash plugin. This isn't
sign-at-compilation-time; bsign can sign just about anything (although I
guess the Mozilla security shared library, which is itself signed by a
different tool, might pose an interesting conundrum).

> and the stack can be executable if the app wants it to be as well...

Well, yes, but if the app isn't signed the attacker can't run it.
Obviously digsig doesn't close all avenues of attack: you'd use
exec-shield or something of the kind to block off the executable-stack
thing from the majority of apps (and yes, if you flip PT_GNU_STACK you
should resign the app, IIRC).

> so it's not all that easy as you make it sound

Everyone seems to want the One Security Fix To Rule Them All. This
isn't it: it's just one of a myriad of barriers to throw in the
bad guys' way. None of them stop everyone: most of them should
stop most of them.

I'm not trying to keep governments out. If they want in, they'll
*get* in, if need be by breaking in and physically removing the
machine...

>> will sign every ELF shared object and executable on the system.
> 
> but it won't sign the not-really-elf-but-virus-anyway files. 

The idea is that you don't *have* them on there when you do the
initial signing round, and that after that you only sign the
stuff you install yourself (and, of course, that you don't keep
the key on the same machine, or even accessible without physical
actions, I'd hope: that's why I keep mine on a CD-ROM physically
removed from the drive when not signing).

-- 
`On a scale of 1-10, X's "brokenness rating" is 1.1, but that's only
 because bringing Windows into the picture rescaled "brokenness" by
 a factor of 10.' --- Peter da Silva
