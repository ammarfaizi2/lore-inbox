Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277687AbRKAC0U>; Wed, 31 Oct 2001 21:26:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277692AbRKAC0L>; Wed, 31 Oct 2001 21:26:11 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:32504
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S277687AbRKAC0A>; Wed, 31 Oct 2001 21:26:00 -0500
Date: Wed, 31 Oct 2001 18:26:32 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: linux-kernel@vger.kernel.org
Subject: Merging several patches - Tips and Tricks
Message-ID: <20011031182632.D15598@mikef-linux.matchmail.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Recently I was asked how I was able to merge a few moderately large patches
together.

Here's basically what I told him:
############
Here's what I did instead of manually fixing the reject...

You need three kernel trees for this...

2.4.13.vanilla
2.4.13-ac5 (or whatever -ac)
2.4.13-freeswan

ln -s /usr/src/lk2.4/2.4.13-freeswan /usr/src/linux (for freeswan patching
   proceedure)
cd /usr/src/freeswan-1.91
make insert (no problems with 2.4.13)
cd /usr/src/lk2.4/2.4.13freeswan-1.91
patch 2.4.13-ac5 (two rejects)
cd /usr/src/lk2.4

diff -U1 2.4.13.vanilla/Documentation/Configure.help \
  2.4.13-ac5/Documentation/Configure.help > 2.4.13-ac5-Configure.help-U1.patch
  
mv 2.4.13-freeswan/Documentation/Configure.help~ \
  2.4.13-freeswan/Documentation/Configure.help
    
cd 2.4.13-freeswan
patch -p1 < ../2.4.13-ac5-Configure.help-U1.patch
    
(no rejects!)

Rinse and repeat...

Ok, here's the idea.  Normally, diff uses 3 lines of context, this can cause
it to create larger chunks within the patch, and patch won't split these
hunks up to try to get it to apply.  So, if you have smaller chunks and more
of them, it has a much better chance of being able to integrate it...
######

This proceedure is working for me, but I am rather new to the whole process.
Is there another way that doesn't require so many trees, and disk space?

I'd like people to post their tips and tricks, so maybe we can point to it
when the topic comes up again.  Or, maybe a web site would be better...

Note, none of this will help if the actual code will patch together, but
won't work afterwards...

Mike
