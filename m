Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261201AbVBLVos@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261201AbVBLVos (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Feb 2005 16:44:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261202AbVBLVos
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Feb 2005 16:44:48 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:32948 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261201AbVBLVoq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Feb 2005 16:44:46 -0500
Date: Sat, 12 Feb 2005 13:44:32 -0800
From: Paul Jackson <pj@sgi.com>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: raybry@sgi.com, taka@valinux.co.jp, hugh@veritas.com, akpm@osdl.org,
       marcello@cyclades.com, raybry@austin.rr.com, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC 2.6.11-rc2-mm2 7/7] mm: manual page migration --
 sys_page_migrate
Message-Id: <20050212134432.5c60dd8e.pj@sgi.com>
In-Reply-To: <1108242262.6154.39.camel@localhost>
References: <20050212032535.18524.12046.26397@tomahawk.engr.sgi.com>
	<20050212032620.18524.15178.29731@tomahawk.engr.sgi.com>
	<1108242262.6154.39.camel@localhost>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave wrote:
> Might it be useful to use nodemasks instead of those arrays?

I don't think he can.  A nodemask represents an unorderd set of nodes. 
He needs (or wants) to pass a <nid, nid> map, mapping the node that each
page might be on, to the node to which it should migrate.  A bitmask
doesn't contain enough information to specify that.

Perhaps instead he could pass two node arguments, old and new, with the
migration routines understanding that they were to migrate only pages
found on the old node, to the new node, ignoring other pages.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.650.933.1373, 1.925.600.0401
