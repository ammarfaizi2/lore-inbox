Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268684AbUHZKz3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268684AbUHZKz3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 06:55:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268580AbUHZKzN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 06:55:13 -0400
Received: from levante.wiggy.net ([195.85.225.139]:39837 "EHLO mx1.wiggy.net")
	by vger.kernel.org with ESMTP id S268633AbUHZKyG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 06:54:06 -0400
Date: Thu, 26 Aug 2004 12:54:05 +0200
From: Wichert Akkerman <wichert@wiggy.net>
To: Spam <spam@tnonline.net>
Cc: Andrew Morton <akpm@osdl.org>, jra@samba.org, torvalds@osdl.org,
       reiser@namesys.com, hch@lst.de, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, flx@namesys.com,
       reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040826105404.GH2612@wiggy.net>
Mail-Followup-To: Spam <spam@tnonline.net>, Andrew Morton <akpm@osdl.org>,
	jra@samba.org, torvalds@osdl.org, reiser@namesys.com, hch@lst.de,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	flx@namesys.com, reiserfs-list@namesys.com
References: <20040825152805.45a1ce64.akpm@osdl.org> <112698263.20040826005146@tnonline.net> <Pine.LNX.4.58.0408251555070.17766@ppc970.osdl.org> <1453698131.20040826011935@tnonline.net> <20040825163225.4441cfdd.akpm@osdl.org> <20040825233739.GP10907@legion.cup.hp.com> <20040825234629.GF2612@wiggy.net> <1939276887.20040826114028@tnonline.net> <20040826024956.08b66b46.akpm@osdl.org> <839984491.20040826122025@tnonline.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <839984491.20040826122025@tnonline.net>
User-Agent: Mutt/1.5.6+20040523i
X-SA-Exim-Connect-IP: <locally generated>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Previously Spam wrote:
>   Because  having user space tools and code will make it not work with
>   everything. Keeping stuff in the kernel should make the new features
>   transparent to the applications.

But having it in the kernel has the same problem. If you read the
Solaris documentation you will see that a bunch of utilties had to
get a new commandline option to be able to access the metadata and
a special utility was added for other applications. If you look
at windows you will see that you need to use a filename like
<realfilename>:<streamname>:$DATA (which obviously does not work for
single-character filenames).

Ignoring samba for a bit which just needs streams to stay compatible
with windows I see few reasons for using streams:

* files are more complex these days and tend to include multiple
  different things: images with thumbnails and exif data, 'office'
  documents containing both text and images

* standard way to add common metadata to a file which can be used for
  searching tools (author, copyright, keywords, etc.)

But both can already be done in userland (modern image formats can store
thumbnails and exif data internally, applications use tar or zip-like
files for documents, etc.). The metadata part is a lot more complicated
as well since the behaviour of attributes might need to be complex:
if I change an image using an application that is not stream-aware, what
should happen to its thumbnail? 

The only common benefits I can see are standardisation and optimization:
instead of every file format or application defining a way to specify 
metadata for a file you get a common API defined by the OS (but you'll
still need to standardize on attribute names and formats, so plenty of
room that will still not help), and instead of parsing different files
or XML streams you can directly access a bit of metadata.

So far I'm not convinced that streams are worth the effort. Not that my
opinion is all that relevant here, but still :)

Wichert.

-- 
Wichert Akkerman <wichert@wiggy.net>    It is simple to make things.
http://www.wiggy.net/                   It is hard to make things simple.
