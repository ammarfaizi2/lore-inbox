Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271731AbTHDNck (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 09:32:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271736AbTHDNck
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 09:32:40 -0400
Received: from mail3.ithnet.com ([217.64.64.7]:9144 "HELO
	heather-ng.ithnet.com") by vger.kernel.org with SMTP
	id S271731AbTHDNcj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 09:32:39 -0400
X-Sender-Authentification: SMTPafterPOP by <info@euro-tv.de> from 217.64.64.14
Date: Mon, 4 Aug 2003 15:32:36 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Nikita Danilov <Nikita@Namesys.COM>
Cc: linux-kernel@vger.kernel.org
Subject: Re: FS: hardlinks on directories
Message-Id: <20030804153236.5748ba38.skraw@ithnet.com>
In-Reply-To: <16174.21970.527300.160659@laputa.namesys.com>
References: <20030804141548.5060b9db.skraw@ithnet.com>
	<16174.21970.527300.160659@laputa.namesys.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Aug 2003 16:47:14 +0400
Nikita Danilov <Nikita@Namesys.COM> wrote:

> Hard links on directories are hard to do in the UNIX file system model.
> 
> Where ".." should point? How to implement rmdir? You can think about
> UNIX unlink as some form of reference counter based garbage
> collector---when last (persistent) reference to the object is removed it
> is safe to recycle it. It is well-known that reference counting GC
> cannot cope with cyclical references. Usually this is not a problem for
> the file system because all cyclical references are very well
> known---they always involve "." and "..". But as one allows hard links
> on directories, file system is no longer tree, but generic directed
> graph and reference counting GC wouldn't work.

If file-/directory-nodes are single-linked list nodes inside one directory, and
directory-nodes pointing to the same directory are single-linked list nodes,
you can:

- ".." do as first node of a directory and the "shared" part of the directory
follows on its next-pointer, so you have one ".." for every hard-link.
- implement rmdir as throw-away dir-node and ".." node and only if pointer to
next hw-linked directory-node is itself remove rest of linked node list

Are there further questionable operations?

Regards,
Stephan


