Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261930AbVACX1O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261930AbVACX1O (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 18:27:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261935AbVACXZi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 18:25:38 -0500
Received: from terminus.zytor.com ([209.128.68.124]:31392 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261930AbVACXXF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 18:23:05 -0500
Message-ID: <41D9D3C8.1040602@zytor.com>
Date: Mon, 03 Jan 2005 15:22:48 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nicholas Miell <nmiell@comcast.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] get/set FAT filesystem attribute bits
References: <41D9B1C4.5050507@zytor.com>	 <1104787447.3604.9.camel@localhost.localdomain>	 <41D9BA8B.2000108@zytor.com>	 <1104788816.3604.17.camel@localhost.localdomain>	 <41D9C111.2090504@zytor.com>	 <1104790243.3604.23.camel@localhost.localdomain>	 <41D9C64E.7080508@zytor.com> <1104794219.3604.29.camel@localhost.localdomain>
In-Reply-To: <1104794219.3604.29.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Pruning the Cc: list.]

Nicholas Miell wrote:
> On Mon, 2005-01-03 at 14:25 -0800, H. Peter Anvin wrote:
> 
>>I'm honestly not sure that using an ASCII string in an xattr is the sane 
>>way of doing this.  Even a binary byte in an xattr would make more sense 
>>in some ways.
> 
> ASCII strings require no special tools to manipulate from shell scripts.
> 

You need some kind of special tool anyway, i.e. getfattr/setfattr.  What 
tool you use isn't really important.

The fact that getfattr/setfattr can't deal with attributes that aren't 
ASCII strings seem like flaws in these tools.

> 
>>I think the xattr mechanism is ignored largely because it's painfully 
>>complex.
>>
>>A plus with using xattr is that in theory (but of course not in 
>>practice!) it would let one store a copy of a DOS filesystem on an ext3 
>>(or xfs, or...) filesystem and have it restored, all using standard (but 
>>by necessity, xattr-aware) tools.  However, the splitting of xattr into 
>>namespaces may very well make that impossible, since what's a "system" 
>>attribute to one filesystem is a "user" attribute to another.  Classic 
>>design flaw, by the way.
> 
> The design does allow users to store whatever they want as an xattr
> without having to worry about how the kernel chooses to interpret it,
> though. (i.e. the user namespace is just a byte array that the kernel
> stores for you, while the system/security namespaces are probably
> generated and interpreted on demand.)
 >

Exactly, and that's a total screwup.  It makes something that would 
otherwise be possible -- for some filesystems to have an attribute (call 
it "system.dosattrib") which is used, and for others which is stored. 
The problem is that with the current design, that won't happen.

Encoding this in the namespace, therefore preventing this kind of 
compatiblity, is daft.  From the looks of it, the CIFS people were 
planning to do the "put everything in user.*" workaround for this design 
error.

	-hpa
