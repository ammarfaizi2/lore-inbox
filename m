Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261262AbUKSJBT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261262AbUKSJBT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 04:01:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261318AbUKSJBT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 04:01:19 -0500
Received: from asplinux.ru ([195.133.213.194]:48393 "EHLO relay.asplinux.ru")
	by vger.kernel.org with ESMTP id S261262AbUKSJBR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 04:01:17 -0500
Message-ID: <419DB6BA.5040901@sw.ru>
Date: Fri, 19 Nov 2004 12:02:50 +0300
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [BUG?] dev_close() is called with locks held
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

looks like a bug in 2.4/2.6 kernels:

1. dev_close() function is blocking. it calls schedule() inside and 
calls blocking dev_deactivate() function.

2. But... call chain
dev_ioctl() -> dev_ifsioc() -> dev_change_flags() calls dev_close() 
under read_lock(&dev_base_lock)...

Bug?

Kirill

