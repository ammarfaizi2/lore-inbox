Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262254AbVCIK0s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262254AbVCIK0s (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 05:26:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262275AbVCIK0s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 05:26:48 -0500
Received: from moritz.faps.uni-erlangen.de ([131.188.113.15]:38038 "EHLO
	moritz.faps.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S262254AbVCIK0g convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 05:26:36 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Subject: RE: Writing data > PAGESIZE into kernel with proc fs
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
Date: Wed, 9 Mar 2005 11:26:30 +0100
Message-ID: <09766A6E64A068419B362367800D50C0B58A58@moritz.faps.uni-erlangen.de>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Writing data > PAGESIZE into kernel with proc fs
thread-index: AcUkJQCZFx6M8AgqRHODvFS+2DhjngAbRAZ6
From: "Weber Matthias" <weber@faps.uni-erlangen.de>
To: "Jan Hudec" <bulb@ucw.cz>
Cc: <kernelnewbies@nl.linux.org>, <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 08, 2005 at 20:05:42 +0100, Weber Matthias wrote:
>> is there any chance to signal an EOF when writing data to kernel via proc fs? >> Actually if the length of data is N*PAGE_SIZE it seems not to be detectable. 
>> I followed up the "struct file" but haven't found anything that helped...

> End-of-file is signified by closing the file. As usual.

Having only this struct describing an proc entry, i have no idea on how to detect when the file is closed. For this i expect to register a callback function but where and how?

struct proc_dir_entry {
	unsigned int low_ino;
	unsigned short namelen;
	const char *name;
	mode_t mode;
	nlink_t nlink;
	uid_t uid;
	gid_t gid;
	unsigned long size;
	struct inode_operations * proc_iops;
	struct file_operations * proc_fops;
	get_info_t *get_info;
	struct module *owner;
	struct proc_dir_entry *next, *parent, *subdir;
	void *data;
	read_proc_t *read_proc;
	write_proc_t *write_proc;
	atomic_t count;		/* use count */
	int deleted;		/* delete flag */
};

Thanks,
Matthias
