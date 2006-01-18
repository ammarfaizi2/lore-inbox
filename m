Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964901AbWARSME@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964901AbWARSME (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 13:12:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964907AbWARSME
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 13:12:04 -0500
Received: from smtp-103-wednesday.nerim.net ([62.4.16.103]:10503 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S964901AbWARSMB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 13:12:01 -0500
Date: Wed, 18 Jan 2006 19:12:47 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>, Sam Ravnborg <sam@ravnborg.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Eyal Lebedinsky <eyal@eyal.emu.id.au>
Subject: Re: Linux 2.6.16-rc1
Message-Id: <20060118191247.62cc52cd.khali@linux-fr.org>
In-Reply-To: <Pine.LNX.4.61.0601181421210.19392@yvahk01.tjqt.qr>
References: <Pine.LNX.4.64.0601170001530.13339@g5.osdl.org>
	<43CD67AE.9030501@eyal.emu.id.au>
	<20060117232701.GA7606@mars.ravnborg.org>
	<20060118085936.4773dd77.khali@linux-fr.org>
	<20060118091543.GA8277@mars.ravnborg.org>
	<Pine.LNX.4.61.0601181421210.19392@yvahk01.tjqt.qr>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jan, Sam,

> Anyway, SUSE 10.0/i386:
> 
> 14:20 takeshi:~ > l /dev/null
> crw-rw-rw-  1 root root 1, 3 Sep  9 18:40 /dev/null
> 14:20 takeshi:~ > echo 'main(){}' | gcc -xc -c - -o /dev/null
> 14:21 takeshi:~ > echo $?
> 0
> 14:21 takeshi:~ > l /dev/null
> crw-rw-rw-  1 root root 1, 3 Sep  9 18:40 /dev/null
> 
> 
> 14:22 takeshi:/home/jengelh # echo 'main(){}' | gcc -xc -c - -o /dev/null
> 14:22 takeshi:/home/jengelh # echo $?
> 0
> 14:22 takeshi:/home/jengelh # l /dev/null
> crw-rw-rw-  1 root root 1, 3 Sep  9 18:40 /dev/null
> 
> So what is (not) happening?

This ain't exactly the same command Sam had me test earlier today. This
one breaks my /dev/null:

  echo "main() {}" | gcc -xc - -o /dev/null

But this one doesn't:

  echo 'main() {}' | gcc -xc -c - -o /dev/null

I.e., the additional -c seems to make a difference (at least in my
case.) Sam, maybe that's an easier and more efficient fix than
resorting to a temporary file?

Thanks,
-- 
Jean Delvare
