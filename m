Return-Path: <linux-kernel-owner+w=401wt.eu-S1759146AbWLIWyp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759146AbWLIWyp (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 17:54:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759148AbWLIWyp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 17:54:45 -0500
Received: from nz-out-0506.google.com ([64.233.162.228]:39024 "EHLO
	nz-out-0102.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759146AbWLIWyo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 17:54:44 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=J8EZ2730BAQuaER+M8/d4AAwogY3rrKiwdk+LrdcW7b0fTjKbuYz58c/0aTC/fiGXP6QFT12xVfKBheZV5Q0Y/xFu8gPUNCwnVubsDGWnQYk9cjEicdCDJ02uLgXpr5KcP+TPjr0JwWMm+RScpjXUDqeMwxbIpc5zsfGzWHsuvw=
Message-ID: <b0943d9e0612091454j6df1fb0ej2fa006c3fa33abae@mail.gmail.com>
Date: Sat, 9 Dec 2006 22:54:43 +0000
From: "Catalin Marinas" <catalin.marinas@gmail.com>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Possible memory leak in ata_piix.c
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Kmemleak found a possible memory leak in piix_init_one() in
drivers/ata/ata_piix.c. This only appeared after 2.6.19, maybe caused
by the recent patches to this area. Kmemleak cannot find any track of
the kzalloc'ed piix_host_priv structure allocated in the above
function and reports it. The allocation stack trace is below:

unreferenced object 0xde9bca60 (size 4):
  [<c018d85d>] __kmalloc_track_caller
  [<c0179249>] __kzalloc
  [<c02cf33f>] piix_init_one
  [<c023dc2d>] pci_call_probe
  [<c023dc81>] __pci_device_probe
  [<c023dcb9>] pci_device_probe
  [<c029b5fc>] really_probe
  [<c029b728>] driver_probe_device
  [<c029b8c1>] __driver_attach
  [<c029a879>] bus_for_each_dev
  [<c029b8e9>] driver_attach
  [<c029ae9c>] bus_add_driver
  [<c029bd27>] driver_register
  [<c023e035>] __pci_register_driver
  [<c02cf4ef>] piix_init

Thanks.

-- 
Catalin
