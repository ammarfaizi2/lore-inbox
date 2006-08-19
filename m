Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751709AbWHSK6n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751709AbWHSK6n (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Aug 2006 06:58:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751701AbWHSK6m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Aug 2006 06:58:42 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:15736 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751425AbWHSK6m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Aug 2006 06:58:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=O/HAEYeEexlqi56Ps7IEndHctQj8e1j6PI6i2E2E5CK2WwaGQHvHTXGewfV05IDNTLwZoWwCSr5In6PIrC0vJmrMGn22PfBY5ziXSJeR3jKV6R6A4xXzi7kruUZZs+0NdYT2qufNBhb99oTpDBo3kZOe+Mg08GpHXInOdXUJdbM=
Message-ID: <b0943d9e0608190358i7cb93b75g1b52d2f1b7e6f1a@mail.gmail.com>
Date: Sat, 19 Aug 2006 11:58:41 +0100
From: "Catalin Marinas" <catalin.marinas@gmail.com>
To: "Shailabh Nagar" <nagar@watson.ibm.com>
Subject: Possible memory leak in kernel/delayacct.c
Cc: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shailabh,

Michal was running some kmemleak tests and there are about 20 orphan
pointers reported in delayacct.c. The allocation backtrace is:

orphan pointer 0xf548fde0 (size 76):
  c0174674: <kmem_cache_zalloc>
  c01591ee: <__delayacct_tsk_init>
  c0127e06: <copy_process>
  c0128cd2: <do_fork>
  c0104d39: <sys_clone>

I'm not sure whether the leak occurs but there might be a path where
task_struct is freed and the task->delays pointer is lost. Could you
please have a look at this? Thanks.

-- 
Catalin
