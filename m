Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266100AbSLOAeA>; Sat, 14 Dec 2002 19:34:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266101AbSLOAeA>; Sat, 14 Dec 2002 19:34:00 -0500
Received: from gaea.projecticarus.com ([195.10.228.71]:53174 "EHLO
	gaea.projecticarus.com") by vger.kernel.org with ESMTP
	id <S266100AbSLOAd7>; Sat, 14 Dec 2002 19:33:59 -0500
Message-ID: <3DFBCFA2.7030603@walrond.org>
Date: Sun, 15 Dec 2002 00:41:06 +0000
From: Andrew Walrond <andrew@walrond.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Stephen Wille Padnos <stephen.willepadnos@verizon.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Symlink indirection
References: <200212141355.gBEDtb7q000952@darkstar.example.net> <3DFB3983.3090602@walrond.org> <3DFB8B7C.10802@verizon.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi steve

Stephen Wille Padnos wrote:
> 
> What would you expect to happen if you then did:
> echo "d/w" > d/w
> 
> Which physical directory would you expect a new file to go into?
> 

Using my example:

mkdir a
echo "a/x" > a/x
echo "a/y" > a/y
echo "a/z" > a/z

mkdir b
echo "b/y" > b/y

mkdir c
echo "c/z" > c/z

mkdir d
mount --bind a d
mount --bind --overlay b d
mount --bind --overlay c d

cat d/x
"a/x"

cat d/y
"b/y"

cat d/z
"c/z"

Then...

echo "d/w" > d/w would create a new file in directory a.
echo "d/y" > d/y would replace the file b/y
etc...

Is this sort of thing possible, or are there fundamental reasons that 
would make it difficult?

Andrew

