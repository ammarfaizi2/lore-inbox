Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030420AbWARUcj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030420AbWARUcj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 15:32:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030422AbWARUcj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 15:32:39 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:3597 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1030420AbWARUcj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 15:32:39 -0500
Date: Wed, 18 Jan 2006 21:32:32 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Jean Delvare <khali@linux-fr.org>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       LKML <linux-kernel@vger.kernel.org>,
       Eyal Lebedinsky <eyal@eyal.emu.id.au>
Subject: Re: Linux 2.6.16-rc1
Message-ID: <20060118203231.GA14340@mars.ravnborg.org>
References: <Pine.LNX.4.64.0601170001530.13339@g5.osdl.org> <43CD67AE.9030501@eyal.emu.id.au> <20060117232701.GA7606@mars.ravnborg.org> <20060118085936.4773dd77.khali@linux-fr.org> <20060118091543.GA8277@mars.ravnborg.org> <Pine.LNX.4.61.0601181421210.19392@yvahk01.tjqt.qr> <20060118191247.62cc52cd.khali@linux-fr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060118191247.62cc52cd.khali@linux-fr.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2006 at 07:12:47PM +0100, Jean Delvare wrote:
> Hi Jan, Sam,
> 
> > Anyway, SUSE 10.0/i386:
> > 
> > 14:20 takeshi:~ > l /dev/null
> > crw-rw-rw-  1 root root 1, 3 Sep  9 18:40 /dev/null
> > 14:20 takeshi:~ > echo 'main(){}' | gcc -xc -c - -o /dev/null
> > 14:21 takeshi:~ > echo $?
> > 0
> > 14:21 takeshi:~ > l /dev/null
> > crw-rw-rw-  1 root root 1, 3 Sep  9 18:40 /dev/null
> > 
> > 
> > 14:22 takeshi:/home/jengelh # echo 'main(){}' | gcc -xc -c - -o /dev/null
> > 14:22 takeshi:/home/jengelh # echo $?
> > 0
> > 14:22 takeshi:/home/jengelh # l /dev/null
> > crw-rw-rw-  1 root root 1, 3 Sep  9 18:40 /dev/null
> > 
> > So what is (not) happening?
> 
> This ain't exactly the same command Sam had me test earlier today. This
> one breaks my /dev/null:
> 
>   echo "main() {}" | gcc -xc - -o /dev/null
> 
> But this one doesn't:
> 
>   echo 'main() {}' | gcc -xc -c - -o /dev/null

Right.
-c tell gcc not to link.
But in the lxdialog case we need to execute the link step, because
what we really try to do is to check if gcc can find a specific
library in the search path.

So in contradiction to the cc-option case where we chank for an option,
we need to perform the link step here.

	Sam
