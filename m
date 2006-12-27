Return-Path: <linux-kernel-owner+w=401wt.eu-S932894AbWL0Ddm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932894AbWL0Ddm (ORCPT <rfc822;w@1wt.eu>);
	Tue, 26 Dec 2006 22:33:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932895AbWL0Ddm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Dec 2006 22:33:42 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:25157 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932894AbWL0Ddl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Dec 2006 22:33:41 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sWhHQtlCAbPNs8HEy89LnKujBHDlAUz4o5GHfK1RHKL9fWVd6qXlPoig2C5L97ylOxljQeBZwxeay3rqWPXjyVHBzSgyBulk/OjDe4PIFZVv1EPePO+L7xEQaahHM3bgRvQT3e37MdXpgG3jY1RC5JvIDE9RrhJNofwwbzLDfrk=
Message-ID: <4df04b840612261933g6eab036rb474930828dadb6d@mail.gmail.com>
Date: Wed, 27 Dec 2006 11:33:39 +0800
From: "yunfeng zhang" <zyf.zeroos@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.16.29 1/1] memory: enhance Linux swap subsystem
Cc: "Zhou Yingchao" <yingchao.zhou@gmail.com>
In-Reply-To: <67029b170612260103o9193346hde726a3f09afa57f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <4df04b840612260018u4be268cod9886edefd25c3a@mail.gmail.com>
	 <67029b170612260103o9193346hde726a3f09afa57f@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

To multiple address space, multiple memory inode architecture, we can introduce
a new core object -- section which has several features
1) Section is used as the atomic unit to contain the pages of a VMA residing in
   the memory inode of the section.
2) When page migration occurs among different memory inodes, new secion should
   be set up to trace the pages.
3) Section can be scanned by the SwapDaemon of its memory inode directely.
4) All sections of a VMA are excluded with each other not overlayed.
5) VMA is made up of sections totally, but its section objects scatter on memory
   inodes.
So to the architecture, we can deploy swap subsystem on an
architecture-independent layer by section and scan pages batchly.

The idea issued by me is whether swap subsystem should be deployed on layer 2 or
layer 3 which is described in Documentation/vm_pps.txt of my patch. To multiple
memory inode architecture, the special memory model should be encapsulated on
layer 3 (architecture-dependent), I think.
