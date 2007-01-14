Return-Path: <linux-kernel-owner+w=401wt.eu-S1750743AbXANA7P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750743AbXANA7P (ORCPT <rfc822;w@1wt.eu>);
	Sat, 13 Jan 2007 19:59:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750823AbXANA7P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Jan 2007 19:59:15 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:50882 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750743AbXANA7O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Jan 2007 19:59:14 -0500
Subject: Patch series to mark struct file_operations and struct
	inode_operations const
From: Arjan van de Ven <arjan@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Content-Type: text/plain
Organization: Intel International BV
Date: Sat, 13 Jan 2007 16:51:08 -0800
Message-Id: <1168735868.3123.315.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

today a sizable portion of the "struct file_operations" variables in the
kernel are const, but by far not all. Nor are any of the struct
inode_operations const. Marking these read-only datastructures const has
the advantage of reducing false sharing of these, often hot,
datastructures. In addition there have been cases where drivers or
filesystems accidentally and incorrectly wrote to such a struct
forgetting that it's a shared datastructure. By marking these const, the
compiler will warn/error on such instances.

The series is split up for size, there isn't really any logical order
for such a simple search-and-replace operation.

Greetings,
   Arjan van de Ven

