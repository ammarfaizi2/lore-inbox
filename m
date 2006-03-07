Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751214AbWCGM6n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751214AbWCGM6n (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 07:58:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751547AbWCGM6n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 07:58:43 -0500
Received: from zproxy.gmail.com ([64.233.162.202]:18508 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751214AbWCGM6m convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 07:58:42 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=AbO39iuT3ZqvDsAZvs9dvt/Fvm/sw6appbrT64WAF4K+gxo3j+hieWYM8pRAENeSQaclRTmrXI9+Ojw5r0DOosickr2FGxSXTAg18v6LIW87von0IUd7jqCJGVvZfwMadCvbkd6dZTGt7OKnlh0hZEwIn+Pa2x0FQwLuNfTnXeY=
Message-ID: <ca8cd3800603070458w64462bc1xcc867514a239c978@mail.gmail.com>
Date: Tue, 7 Mar 2006 17:58:41 +0500
From: "Ali Ahmed Thawerani" <aaht14@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: how to sync page cache
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i have written a wrapper for a block device. my wrapper is also
registered as a block device and i am obtaining the pointer bdev of
the wrapper block device by using the open_by_devnum function with
FMODE_READ | FMODE_WRITE

i want to sync the memory pages that are in the page cache for this
particular wrapper block device

what i am doing is using two functions filemap_fdatawrite and
filemap_fdatawait which take bdev->bd_inode->i_mapping as argument and
sync the data associated with a particular block device

the return status of these two functions is 0 which i think means no success

i have tried to figure out what can be the reason for this and i
followed the function calling that have been made

some of the possible reasons were: when
i_mapping->backing_dev_info->memory_backed is 1 then these functions
return 0 i have checked that this value is not greater than 0 moreover
i have also checked that the i_mapping->nr_pages are also greater than
0

i was not able to go any further

i am calling these two functions in a thread

there was also another problem that when there is some request coming
to my wrapper block device and wake up the thread which tries to sync
the page cache my system gets stuck may be both the threads are trying
to modify the inodes at the same time and none is succeeding

what i did to solve this problem that i used kernel timer if there is
no request in the request queue for jiffies + 30 then i wake up the
thread to sync the buffer cache and at the same time set a
flag........ as according to my assumption when buffer cache will sync
data will come to my wrapper block device and i have to requeue it to
avoid any sort of problem but the thing is no such thing happens that
is there is no new request in request queue at all

can any one help me out in this
