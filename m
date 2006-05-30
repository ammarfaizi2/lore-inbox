Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964783AbWE3W1x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964783AbWE3W1x (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 18:27:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964775AbWE3W1x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 18:27:53 -0400
Received: from wr-out-0506.google.com ([64.233.184.238]:57274 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932524AbWE3W1w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 18:27:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=ktIjFqGp1tgepzJ7fweONC1XtIwudqsfIo1e23yWt5weISP8Hr6vkEjXvPHT6kJSkL05cpu4x+vtr1x/gl40J5uiBvdjZR1ADEADTyFVGfPONRDB4S5ZgT2jTvXl5y8IPbE9xeUw6Ml+PoVALpi4S9cvvdhulGmJKVhdZrEVA2E=
Message-ID: <4ae3c140605301527r59e91f9ah20dde8a4ae812d0e@mail.gmail.com>
Date: Tue, 30 May 2006 18:27:48 -0400
From: "Xin Zhao" <uszhaoxin@gmail.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: NFS implementation redundancy
Cc: linux-fsdevel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am looking at NFS implementation included in kernel 2.6.16. In
nfs/inode.c, function nfs_delete_inode() called nfs_wb_all() after
truncate_inode_pages(). However, truncate_inode_pages is supposed to
flush out pages, why do we still need nfs_wb_all()? Moreover, after
this nfs_wb_all,  function nfs_delete_inode() immediately calls
clear_inode(), which will call nfs_wb_all() again.

This looks redundant to me. Any explaination on this?

Thanks,
Xin
