Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315375AbSGYQ1a>; Thu, 25 Jul 2002 12:27:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315388AbSGYQ1a>; Thu, 25 Jul 2002 12:27:30 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:14346 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S315375AbSGYQ10>; Thu, 25 Jul 2002 12:27:26 -0400
Message-ID: <3D40279D.6030206@zytor.com>
Date: Thu, 25 Jul 2002 09:30:21 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020703
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: Andreas Dilger <adilger@clusterfs.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Header files and the kernel ABI
References: <aho5ql$9ja$1@cesium.transmeta.com> <20020725065109.GO574@clusterfs.com> <3D3FA3B2.9090200@zytor.com> <20020725073221.GP574@clusterfs.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger wrote:
> 
> That brings up the question - how do you tie a particular
> <linux/abi/*.h> to a particular kernel?  Should there be a bunch of
> directories <linux/abi-2.4/*.h> and/or <linux/abi-2.4.12/*.h> and/or
> <linux/abi-`uname -r`/*.h> or what?  While there are efforts to keep
> the ABI constant for major stable releases, this is not always true,
> so abi-2.4 will certainly not be enough.  Maybe linux/abi is a symlink
> to the abi directory of currently running kernel?
> 

Well... I guess that depends on what kind of changes we make.  In 
general, I belive linux/abi should be cumulative, i.e. it should 
describe "sys_stat" as well as "sys_oldstat" or whatever it is called. 
ABI changes are hard to deal with regardless; you never really know what 
you're breaking, and you probably have to deal with it on a case-by-case 
basis.  People should at least understand that they're breaking the ABI, 
which I'm not sure they currently are.

In general I believe linux/abi should come from the current kernel, but 
for obvious reasons that doesn't mean it's the kernel that's running 
when the application is actually being executed.  This sort of things 
apply to all ABI changes, inherently, which is why 
non-backwards-compatible ABI changes must be avoided.  Ultimately, 
though, it's up to the person who changes it to do the appropriate thing.

	-hpa



