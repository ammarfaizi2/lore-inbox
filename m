Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269669AbUJMKaJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269669AbUJMKaJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 06:30:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269672AbUJMKaI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 06:30:08 -0400
Received: from phoenix.infradead.org ([81.187.226.98]:12805 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S269669AbUJMK34 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 06:29:56 -0400
Date: Wed, 13 Oct 2004 11:29:55 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Thomas Spatzier <thomas.spatzier@de.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: __put_task_struct unresolved when being used in modules
Message-ID: <20041013102955.GB30851@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Thomas Spatzier <thomas.spatzier@de.ibm.com>,
	linux-kernel@vger.kernel.org
References: <OF31970E09.9A7F3D25-ONC1256F2C.00380546-C1256F2C.00389262@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF31970E09.9A7F3D25-ONC1256F2C.00380546-C1256F2C.00389262@de.ibm.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2004 at 12:17:54PM +0200, Thomas Spatzier wrote:
> 
> 
> 
> 
> I have a module that keeps a reference to a task_struct and uses
> get_task_struct and put_task_struct to increment/decrement the
> task_struct's ref count.
> Function __put_task_struct defined in kernel/fork.c does not have
> an associated EXPORT_SYMBOL , so I get an unresolved symbol
> error.
> Is there a reason why __put_task_struct is not exported? Otherwise,
> I would just add the missing EXPORT_SYMBOL. There are a number
> of EXPORT_SYMBOLs already defined in fork.c anyway.

In general module shouldn't deal with task reference counts.  If we decide
you have a legitimate reason for doing this from a module after a review here
on lkml we could add an EXPORT_SYMBOL_GPL at the same time your module gets
merged.

p.s. this is really becoming a FAQ ;-)
