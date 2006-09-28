Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161038AbWI1TqD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161038AbWI1TqD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 15:46:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751991AbWI1TqC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 15:46:02 -0400
Received: from smtp.osdl.org ([65.172.181.4]:62107 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751989AbWI1TqB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 15:46:01 -0400
Date: Thu, 28 Sep 2006 12:45:39 -0700
From: Andrew Morton <akpm@osdl.org>
To: James Morris <jmorris@namei.org>
Cc: linux-kernel@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>,
       Cory Olmo <colmo@TrustedCS.com>
Subject: Re: [PATCH] SELinux - support mls categories for context mounts
Message-Id: <20060928124539.71aa5ee8.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0609281529140.28065@d.namei>
References: <Pine.LNX.4.64.0609281529140.28065@d.namei>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Sep 2006 15:30:53 -0400 (EDT)
James Morris <jmorris@namei.org> wrote:

> This patch allows commas to be embedded into context mount options (i.e. 
> "-o context=some_selinux_context_t"), to better support multiple 
> categories, which are separated by commas and confuse mount.
> 
> For example, with the current code:
> 
>   mount -t iso9660 /dev/cdrom /media/cdrom -o \
>   ro,context=system_u:object_r:iso9660_t:s0:c1,c3,c4,exec
> 
> The context option that will be interpreted by SELinux is
> context=system_u:object_r:iso9660_t:s0:c1
> 
> instead of
> context=system_u:object_r:iso9660_t:s0:c1,c3,c4
> 
> The options that will be passed on to the file system will be
> ro,c3,c4,exec.
> 
> The proposed solution is to allow/require the SELinux context option 
> specified to mount to use quotes when the context contains a comma.

None of this seems to be documented anywhere.  I expect the people who
actually work on this stuff make a pretty tight group, but...
