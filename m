Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751507AbWFUMBf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751507AbWFUMBf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 08:01:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751512AbWFUMBf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 08:01:35 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:64737 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1751507AbWFUMBe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 08:01:34 -0400
From: Junio C Hamano <junkio@cox.net>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: [git pull] ieee1394 tree for 2.6.18
References: <44954102.3090901@s5r6.in-berlin.de>
	<Pine.LNX.4.64.0606191902350.5498@g5.osdl.org>
	<4497D014.1050704@s5r6.in-berlin.de>
	<Pine.LNX.4.64.0606202001520.5498@g5.osdl.org>
	<1150871560.4517.13.camel@grayson>
	<44991622.2000109@s5r6.in-berlin.de>
cc: Jody McIntyre <scjody@modernduck.com>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       linux1394-devel@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ben Collins <bcollins@ubuntu.com>
Date: Wed, 21 Jun 2006 05:01:32 -0700
In-Reply-To: <44991622.2000109@s5r6.in-berlin.de> (Stefan Richter's message of
	"Wed, 21 Jun 2006 11:49:22 +0200")
Message-ID: <7v7j3azpib.fsf@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stefan Richter <stefanr@s5r6.in-berlin.de> writes:

> A related question: If a patch written by author A is forwarded via
> e-mail by person B to git tree maintainer C, and C imports the mail with
> git-am or git-applymbox --- will git catch the _last_ "From: " line
> (hopefully listing the address of A) or the first "From: " line (which
> contains the forwarding address of B) as author of the patch?
>
> Similarly, will it care for the last or first "Subject: " line? (The
> first line being the actual mail header, the last being a line in the
> mail body or a line in a plain-text encoded attachment, that is.)

The main question was answered by Ben, so this may be a bit
offtopic, but I'll answer git questions anyway.

The author-name-email, subject, and author-date are taken from
the RFC2822 headers of the e-mail the committer feeds git-am,
but you can override them by having "From: ", "Subject: ", and
"Date: " as the first lines of the message body, like this:

    From: "For W. Arder" <forwarder@example.com>
    Date: Wed, 21 Jun 2006 11:49:22 +0200
    Subject: forwarding patch (was Re: ieee1394)
    Message-ID: ...

    From: Stefan Richter <stefanr@s5r6.in-berlin.de>
    Date: Mon Jun 12 18:16:25 2006 -0400
    Subject: eth1394: replace __constant_htons by htons

    ...and __constant_ntohs, __constant_ntohl, __constant_cpu_to_be32 too
    where possible.  Htons and friends are resolved to constants in these
    places anyway.  Also fix an endianess glitch in a log message, spotted
    by Alexey Dobriyan.

    Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>

Note that the latter three header-looking lines are not RFC2822
headers but part of your (eh, Mr Arder's) message body.

