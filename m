Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261593AbSKLIZ4>; Tue, 12 Nov 2002 03:25:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266297AbSKLIZG>; Tue, 12 Nov 2002 03:25:06 -0500
Received: from holomorphy.com ([66.224.33.161]:39865 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S266307AbSKLIYf>;
	Tue, 12 Nov 2002 03:24:35 -0500
To: linux-kernel@vger.kernel.org
Subject: [0/11] hugetlb: series to remove custom inode allocation
Message-Id: <E18BWPl-0005K4-00@holomorphy>
From: William Lee Irwin III <wli@holomorphy.com>
Date: Tue, 12 Nov 2002 00:28:53 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This series of patches removes the custom inode allocator from
arch/i386/mm/hugetlbpage.c

It's broken up into 11 incremental steps that progressively reduce
inode dependence, and in the final two stages replace the inode usage
entirely with direct usage of radix trees and refcounting.

The level of testing is very low, but I'd like to release this early.

[1/11]  hugetlb: revert doublefreeing patch
[2/11]  hugetlb: wrap set_new_inode() with alloc_key()
[3/11]  hugetlb: wrap release path with release_key()
[4/11]  hugetlb: wrap hugetlb_prefault with prefault_key()
[5/11]  hugetlb: embed busy flag in key structure
[6/11]  hugetlb: remove direct usage of struct inode
[7/11]  hugetlb: substitute hugetlb_key for struct inode
[8/11]  hugetlb: reduce inode usage in prefault_key()
[9/11]  hugetlb: move inode attributes into hugetlb_key
[10/11] hugetlb: use radix trees instead of inodes
[11/11] hugetlb: add reference counting to hugetlb_keys


Bill
