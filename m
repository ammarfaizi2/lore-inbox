Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261661AbVFZXme@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261661AbVFZXme (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 19:42:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261666AbVFZXme
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 19:42:34 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:19840 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261661AbVFZXmb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 19:42:31 -0400
Message-ID: <42BF3D6B.7000404@namesys.com>
Date: Sun, 26 Jun 2005 16:42:35 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>,
       Alexander Zarochentcev <zam@namesys.com>
CC: Alexander Zarochentsev <zam@namesys.com>, Jeff Garzik <jgarzik@pobox.com>,
       reiserfs-list@namesys.com, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: reiser4 plugins
References: <20050620235458.5b437274.akpm@osdl.org> <42B8B9EE.7020002@namesys.com> <42B8BB5E.8090008@pobox.com> <200506221824.32995.zam@namesys.com> <20050622142947.GA26993@infradead.org> <42BA2ED5.6040309@namesys.com> <20050626164606.GA18942@infradead.org>
In-Reply-To: <20050626164606.GA18942@infradead.org>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:

>On Wed, Jun 22, 2005 at 08:39:01PM -0700, Hans Reiser wrote:
>  
>
>>Correct me if I am wrong:
>>
>>What exists currently in VFS are vector instances, not classes. Plugins,
>>selected by pluginids, are vector classes, with each pluginid selecting
>>a vector class. You propose to have the vector class layer (aka plugin
>>layer) in reiser4 export the vector instance to VFS for VFS to handle
>>for each object, rather than having VFS select reiser4 and reiser4
>>selecting a vector class (aka plugin) which selects a method.
>>
>>If we agree on the above, then I will comment further.
>>    
>>
>
>I'm a bit confused about what you're saying here.  What does the 'vector'
>in all these expressions mean?
>  
>
Was your word, I thought, for the *_operation structures.

>In OO terminology our *_operation structures are interfaces.  Each particular
>instance of such a struct that is filled with function pointers is a class.
>Each instance of an inode/file/dentry/superblock/... that uses these operation
>vectors is an object.
>
>What I propose (or rather demand ;-)) is that you don't duplicate this
>infrastructure, and add another dispath layer below these objects but instead
>re-use it for what it is done and only handle things specific to reiser4
>in your own code. 
>
Well, that is very different from saying that we get rid of the plugin
layer.

So, rather than having a hierarchy, in which we first select filesystem,
and then select plugin, VFS should treat each plugin as though it was a
filesystem, if I understand you. Plugins and pluginids continue to exist
with the exact same functionality, we just eliminate a function
dereference for the *_operation structures. Let's see how it codes up in
its details.

Zam, can you work on this?

Hans
