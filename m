Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263186AbVFXHNd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263186AbVFXHNd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 03:13:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263189AbVFXHNc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 03:13:32 -0400
Received: from sj-iport-5.cisco.com ([171.68.10.87]:2859 "EHLO
	sj-iport-5.cisco.com") by vger.kernel.org with ESMTP
	id S263186AbVFXHLW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 03:11:22 -0400
X-IronPort-AV: i="3.93,225,1115017200"; 
   d="scan'208"; a="193924950:sNHT30003912"
Message-ID: <42BBB1FA.7070400@cisco.com>
Date: Fri, 24 Jun 2005 17:10:50 +1000
From: Lincoln Dale <ltd@cisco.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hans Reiser <reiser@namesys.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, David Masover <ninja@slaphack.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins
References: <200506231924.j5NJOvLA031008@laptop11.inf.utfsm.cl>	 <42BB31E9.50805@slaphack.com> <1119570225.18655.75.camel@localhost.localdomain> <42BB5E1A.70903@namesys.com> <42BB7083.2070107@cisco.com> <42BBAD0F.2040802@namesys.com>
In-Reply-To: <42BBAD0F.2040802@namesys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser wrote:

>Lincoln Dale wrote:
>
>  
>
>>the irony of this whole thread is that history is repeating itself. 
>>see http://www.ussg.iu.edu/hypermail/linux/kernel/0112.1/0519.html
>>kernel developers pushed back on you 3 years ago - in 2001 - what has
>>really changed?
>>    
>>
>
>It is exactly the same, but rather than dwell on that, I'll just remind
>that I have sent out two technical emails which talk only about the
>issue of plugins and pluginids, and whether plugins are classes rather
>than just instances, and whether the classes really would benefit from
>being instantiated into VFS at the cost of keeping the same info in two
>places, and I got no answer on them.  Zam pointed out that our plugins
>do more than just VFS operations, and got no response on that or his
>other points.
>
>Regarding trust, Christophe comes out the gate using the words "useless
>abstraction layer" that happens to be a core feature of our design,
>demanding we cut it out, and not really understanding it or recognizing
>any functionality it provides, and you can't really expect me to respect
>this, can you?
>  
>
heh.  one example i didn't mention in the myriad of EVMS, IPv6, IPSec et 
al was iSCSI.
Christoph was (rightly so) very strong in pushing back on things that 
needed to be fixed/changed/addressed in linux-iscsi, a project near & 
dear to much of the paid work i do.

while i'm sure Christoph could probably be more tactful at times, his 
views on technical matters in the kernel are respected.
the key here is to not take it personally - but instead just understand 
that this is the framework that you have to work in to get it into the 
mainline kernel.

if you don't want to go down that path, you're free to do so.  its open 
source, you can keep your own linux-kernel fork.
but if you want to get your code into mainline, i don't think its so 
much a case of l-k folks telling you how to make your code work under 
VFS.  the onus is on you to say WHY your code and plugins could never be 
put into VFS.

if anything, you should be thankful that Al hasn't yet commented. :)
 

>Now, if his target is reduced to whether we can eliminate a function
>indirection, and whether we can review the code together and see if it
>is easy to extend plugins and pluginids to other filesystems by finding
>places to make it more generic and accepting of per filesystem plugins,
>especially if it is not tied to going into 2.6.13, well, that is the
>conversation I would have liked to have had.
>
>  
>
fantastic - some common ground.
any reason WHY there has to be an abstraction of 'pluginid' when in 
theory VFS operations can already provide the necessary abstraction on a 
per-object basis?

Nikita basically said as much in Message-ID: 
<17081.30107.751071.983835@gargle.gargle.HOWL> earlier in this thread:
    "But it is not so. There _are_ plugins-in-the-VFS. VFS operates on 
opaque
     objects (inodes, dentries, file system types) through interfaces:
     {inode,address_space,dentry,sb,etc.}_operations. Every file system
     back-end if free to implement whatever number of these interfaces. And
     the do this already: check the sources; even ext2 does this: e.g.,
     ext2_fast_symlink_inode_operations and ext2_symlink_inode_operations.

     This is exactly what upper level reiser4 plugins are for.

     I guess that one of Christoph Hellwig's complaints is that reiser4
     introduces another layer of abstraction to implement something that
     already exists."

i never saw any reason why there can't be specific VFS operations put 
together for specific inodes if the policy for that inode dictates any 
special operation (e.g. compression).



cheers,

lincoln.
