Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268965AbUHZOnp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268965AbUHZOnp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 10:43:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268976AbUHZOno
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 10:43:44 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:27396 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S268965AbUHZOj6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 10:39:58 -0400
From: Felipe Alfaro Solana <lkml@felipe-alfaro.com>
To: Spam <spam@tnonline.net>
Subject: Re: silent semantic changes with reiser4
Date: Thu, 26 Aug 2004 16:39:45 +0200
User-Agent: KMail/1.7
Cc: Rik van Riel <riel@redhat.com>, Andrew Morton <akpm@osdl.org>,
       wichert@wiggy.net, jra@samba.org, torvalds@osdl.org, reiser@namesys.com,
       hch@lst.de, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, reiserfs-list@namesys.com
References: <1453776111.20040826131547@tnonline.net> <Pine.LNX.4.44.0408260938340.26316-100000@chimarrao.boston.redhat.com> <1714037053.20040826155924@tnonline.net>
In-Reply-To: <1714037053.20040826155924@tnonline.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408261639.46951.lkml@felipe-alfaro.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 26 August 2004 15:59, Spam wrote:

>   Backup to me is a special case, not simply a copy of files, but also
>   retaining all the extra data, info, attributes, etc, that comes with
>   the file.
>
>   Enabling  support  to  have  all  of  this  extra  stuff  below  the
>   application  level  it  will  be  possible to retain everything even
>   though applications do not support them.
>
>   Backup tools, however, must know about these new features to be able
>   to  backup  them.  And so will every tool that directly accesses the
>   filesystem instead of using the OS API for it.

Thus, this kind of metadata API must be made accessible through the VFS layer, 
if we want to make it FS-independent (not tied to Reiser4). If the real FS 
does not support metadata operations, just ignore them (much like in ISO9660 
ignoring write operations).

>   And  from  I  learned  in an earlier message, tools like cp actually
>   work  on  the  fs level and themselves move the data to the new file
>   instead   of  letting  the OS handle it. This seem to me as it could
>   be  dangerous and could also prevent any kind of enhancements to the
>   FS unless every tool like cp is patched.

I still don't understand why a copy_file() syscall is still missing.
