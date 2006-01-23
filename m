Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964969AbWAWWu5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964969AbWAWWu5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 17:50:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964970AbWAWWu5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 17:50:57 -0500
Received: from mail.customers.edis.at ([62.99.242.131]:1971 "EHLO
	smtp-1.edis.at") by vger.kernel.org with ESMTP id S964969AbWAWWu4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 17:50:56 -0500
Message-ID: <43D55DC3.9080900@lawatsch.at>
Date: Mon, 23 Jan 2006 23:50:43 +0100
From: Philip Lawatsch <philip@lawatsch.at>
Organization: WaUG HQ Graz
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8) Gecko/20060114 Thunderbird/1.5 Mnenhy/0.7.3.0
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: NFSv3 / VFS and group problems
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've had the joy to debug a production system with a really crappy setup.

They have a user "fred" which belongs to ~5000 groups (say 
group1-group5000).


So far so bad. Even worse, they have a nfs backend  with lots of files 
which are owned by users belonging to these groups.

Ok, now my problem is that "fred" can open a file which is

-rw-rw----  someone group300 foo

but a read on this file will fail with EIO

Since group300 is way beyond the 16 groups nfs supports shouldn't fred 
actually get a EACCES back from the open call?

Problem happens with 2.6.13 (vanilla, not tainted) on both server and 
client.


kind regards Philip
