Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424890AbWLHHHx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424890AbWLHHHx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Dec 2006 02:07:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424900AbWLHHHw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 02:07:52 -0500
Received: from nf-out-0910.google.com ([64.233.182.188]:37882 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1424890AbWLHHHw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 02:07:52 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Y6kYELKVan3mnMnO26DBU59sGJEa7yWD1NL25NQMu1qIE1EZHmuh51hTqEiZAKvdgdyx0tnJ8hYD6RVg6b2wrOhIX4NL5WRAP9qcNHdcLWzTRTxgUMDBgfzhPMqXlZM4yYKQY9+B0Pi6DQuAdXrUPdSsm+WML7r5GpcB6K7t8Iw=
Message-ID: <a574553e0612072307v766c3742pd3b4c46fb4fd0470@mail.gmail.com>
Date: Fri, 8 Dec 2006 02:07:50 -0500
From: "kernel list" <list.kernel@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: vmlist_lock locking
Cc: list.kernel@gmail.com
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My understanding is that get_vm_area_node etc. can't be called in
interrupt context because vmlist_lock is obtained with read_lock /
write_lock. I am wondering if it makes sense to use read_lock_bh /
write_lock_bh so that get_vm_area_node can be called in soft interrupt
context. All the code executed when holding vmlist_lock is walking
through the list, so it shouldn't change the behavior. If it does make
sense, BUG_ON(in_interrupt()) can be changed to BUG_ON(in_irq()).
