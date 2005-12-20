Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932142AbVLTVr3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932142AbVLTVr3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 16:47:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932143AbVLTVr3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 16:47:29 -0500
Received: from zproxy.gmail.com ([64.233.162.202]:24285 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932142AbVLTVr2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 16:47:28 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=U2y7dDZ+NIold9pT08NIwkVkjZDRLKPN/aYhIDwV+DE0Iq3jCdlEwFioSz+/YQiCEDuB3iBgE/g+prMsXtqJyQY02ehWAEeKYV8JKVWBTwYIQUg6AvRLNvZsAaPilpRxyEQ0tshnsLJfRyAKuFHF8Eqo6rPiNZ+nGz+RI/rl/y8=
Message-ID: <43A87BB6.4080401@gmail.com>
Date: Wed, 21 Dec 2005 05:46:30 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20051025)
MIME-Version: 1.0
To: Jesper Juhl <jesper.juhl@gmail.com>
CC: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: vgacon regression
References: <9a8748490512201203s7fce043byfce95b11307008d5@mail.gmail.com>
In-Reply-To: <9a8748490512201203s7fce043byfce95b11307008d5@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl wrote:
> Hi Antonino,
> 
 > Any advice as to what patches I can try to revert?
> 
> While I wait for a reply I'll test the mainline kernels between
> 2.6.15-rc5-git4 and 2.6.15-rc6-git1 to try and determine the first one
> that breaks.

More info.  The vgacon is actually restored by X as vgacon does not
touch the hardware anymore (unless you resize the console with stty). So
any patch that affects X is a culprit.  More specifically, the X driver
used was vesa, which means that the vgacon restoration would be done
using VBE state save and state restore function calls.  With X, this would
involve lrmi (the same library used by vbetool).

I wasn't able to duplicate this problem, using Xorg vesa and vgacon 80x25.

Also, there are no changes to vgacon or to the console that I know of between
the versions he mentioned.

To Jesper,

>From your description, I would presume that the VGA fontmap was not
adequately restored.  Can you try changing your system font using whatever
utility is available for your system, such as setfont?  Choose any 8x16 font
in the consolefont directory (It's usually in /usr/share/kbd/consolefont)

Tony

PS: I'll be offline from the 22nd of December to early January 2006.  I
_might_ be able to occasionally answer by e-mail.
