Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264321AbUD0Tsj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264321AbUD0Tsj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 15:48:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264310AbUD0TsW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 15:48:22 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:57308 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S264301AbUD0Tra
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 15:47:30 -0400
Subject: Re: [PATCH COW] sys_copyfile
From: Steve French <smfltc@us.ibm.com>
To: =?ISO-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: linux-kernel@vger.kernel.org, linux-cifs-client@lists.samba.org,
       jra@samba.org
In-Reply-To: <20040427164220.GB2176@wohnheim.fh-wedel.de>
References: <1083081505.12804.65.camel@stevef95.austin.ibm.com>
	 <20040427164220.GB2176@wohnheim.fh-wedel.de>
Content-Type: text/plain; charset=ISO-8859-1
Organization: IBM
Message-Id: <1083095178.4792.4.camel@stevef95.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 27 Apr 2004 14:46:19 -0500
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-04-27 at 11:42, Jörn Engel wrote:

> Shouldn't it be rather
> 
> 	if (old_nd->dentry->d_inode->i_op->copy)
> 		return old_nd->dentry->d_inode->i_op->copy(old_nd->dentry,
> 				mode, new_dentry);
> 
> or something similar?  The copy() effectively replaces the complete
> create/sendfile/possibly-unlink series.
> 

In some network protocols the client does not know whether the server
wants to support copy operation or not (perhaps if the files were on
different server partitions the server might return an error e.g), in
those cases the filesystem client could return error not supported or
equivalent and the remainder of your function is executed doing the copy
the harder way (open/read/close create/write/close) but still faster a
few percent faster than before your patch.

