Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751388AbWCaQKZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751388AbWCaQKZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 11:10:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751395AbWCaQKZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 11:10:25 -0500
Received: from nproxy.gmail.com ([64.233.182.187]:33181 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751388AbWCaQKY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 11:10:24 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=qQiHcsm3fwywdyEfw4XvBQ3LAP7ZXa0TtcOgITIfGFi5LpuYBN/bWY3lRUY0pGEl1axCECn+4Q89cRHhA85BcANCYAZBIm+Qixc+dA4idWOg0Zxr3XDmMJKNP/rVCuUO77sGkuFsw/6pP0M6fOJjvK7TuLebkBhFTJwGOv0ncrU=
Message-ID: <58d0dbf10603310810i52183e5bob5c51d4337ce5c8e@mail.gmail.com>
Date: Fri, 31 Mar 2006 18:10:23 +0200
From: "Jan Kiszka" <jan.kiszka@googlemail.com>
To: linux-kernel@vger.kernel.org
Subject: safe usage of remove_proc_entry and proc_entry->data
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I just wondered (after using this for years...) what the safe usage of
remove_proc_entry() is when I've registered a dynamic data object with
the proc-entry during creation. I'm creating and deleting proc entries
dynamically, not on module insertion/removal.

What is the clean way to synchronise e.g. an ongoing proc read request
on that entry and its access to the embedded data object vs. the
deregistration and later release of the data object?
remove_proc_entry() is non-blocking and does unfortunately not return
any error in case the deletion is deferred.

In the procfs-guide, I read that I should "free the data entry from
the struct proc_dir_entry *before* [calling] remove_proc_entry()".
Doesn't parse for me so far (how should this help?), and I failed to
find a pattern for this in existing kernel code. Any hints welcome!

Thanks in advance,
Jan
