Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281998AbRKUXab>; Wed, 21 Nov 2001 18:30:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281999AbRKUXaW>; Wed, 21 Nov 2001 18:30:22 -0500
Received: from mail1.amc.com.au ([203.15.175.2]:59653 "HELO mail1.amc.com.au")
	by vger.kernel.org with SMTP id <S281997AbRKUXaJ> convert rfc822-to-8bit;
	Wed, 21 Nov 2001 18:30:09 -0500
Message-Id: <5.1.0.14.0.20011122102342.009f7d00@mail.amc.localnet>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Thu, 22 Nov 2001 10:30:05 +1100
To: ReiserFS List <reiserfs-list@namesys.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
From: Stuart Young <sgy@amc.com.au>
Subject: Re: [reiserfs-list] Re: [REISERFS TESTING] new patches on
  ftp.namesys.com: 2.4.15-pre7
Cc: Dieter =?iso-8859-1?Q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>,
        Nikita Danilov <Nikita@namesys.com>,
        Andreas Dilger <adilger@turbolabs.com>
In-Reply-To: <20011121102517Z281563-17408+16912@vger.kernel.org>
In-Reply-To: <15355.31671.983925.611542@beta.reiserfs.com>
 <200111210110.fAL1Atc11275@beta.namesys.com>
 <20011121011655.M1308@lynx.no>
 <15355.31671.983925.611542@beta.reiserfs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 11:24 AM 21/11/01 +0100, Dieter Nützel wrote:
>Am Mittwoch, 21. November 2001 11:02 schrieb Nikita Danilov:
>
> > Yes, it's right, but currently we have what we have currently. I am
> > going to extend inode-attrs.patch and add new mount option
> > "noattrs". With it ioctls to set and get attributes will continue to
> > work, but attributes themselves will not have any effect. Then, one can
> > boot with "rootflags=noattrs" and read-write root, clear all attributes
> > by chattr -R and remount root.
>
>After I've 'booted  into single user mode with "linux rootflags=noattrs" I
>could change my archives but _NOT_ /dev/console the right way. After the
>second reboot I got the warning and kernel hang, again. Something wrong 
>with your patch or my installation?

Erm, while disabling set and get as a nice idea, you only need to disable 
get. Disabling set will mean you 'cannot' reset the file that is causing 
the problem, because chattr won't actually be able to do what you want.

I haven't looked at the code that chattr uses either, but you may want to 
check at HOW it sets/resets values.

eg: Does it read in the value, change the bit and write it out again, or 
does it just change that bit? If it reads and get is disabled, well then 
you would want to make sure you set the 'full value' that needs to be 
there. Not a bug so much as something that just needs to be documented.


AMC Enterprises P/L    - Stuart Young
First Floor            - Network and Systems Admin
3 Chesterville Rd      - sgy@amc.com.au
Cheltenham Vic 3192    - Ph:  (03) 9584-2700
http://www.amc.com.au/ - Fax: (03) 9584-2755

