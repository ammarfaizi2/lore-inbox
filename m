Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268880AbUHLXo0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268880AbUHLXo0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 19:44:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268888AbUHLXoZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 19:44:25 -0400
Received: from ausmtp02.au.ibm.com ([202.81.18.187]:41873 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP id S268880AbUHLXoM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 19:44:12 -0400
Subject: Re: module.viomap support for ppc64
From: Rusty Russell <rusty@rustcorp.com.au>
To: Hollis Blanchard <hollisb@us.ibm.com>
Cc: Olaf Hering <olh@suse.de>, Dave Boutcher <boutcher@us.ibm.com>,
       linuxppc64-dev@lists.linuxppc.org,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1092339278.19137.8.camel@localhost>
References: <20040812173751.GA30564@suse.de>
	 <1092339278.19137.8.camel@localhost>
Content-Type: text/plain
Message-Id: <1092354195.25196.11.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 13 Aug 2004 09:43:15 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-08-13 at 05:34, Hollis Blanchard wrote:
> On Thu, 2004-08-12 at 12:37, Olaf Hering wrote:
> > Current MODULE_DEVICE_TABLE(vio, $table); defines 2 char pointers. I'm
> > not sure if depmod can really handle it. Where do they point to in the
> > module binary? I could find an answer, so far. I just declared an array.
> 
> Olaf explained on irc that output_vio_entry() below was finding NULL for
> the name and compat pointers. Perhaps some additional relocation needs
> to take place before those can be used?

1) Please use char arrays of some fixed size.

2) Please modify scripts/mod/file2alias.c in the kernel source, not the
module tools.  The modules.XXXmap files are deprecated: device tables
are supposed to be converted to aliases in the build process, and that
is how userspace tools like hotplug are to find them.

3) I will still accept patches to module-init-tools if required for 2.4
compatibility, but they will be going away at some point!

Hope that clarifies!
Rusty.
-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

