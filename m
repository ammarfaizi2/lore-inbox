Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965018AbWHNWsl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965018AbWHNWsl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 18:48:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932744AbWHNWsl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 18:48:41 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:20999 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932740AbWHNWsk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 18:48:40 -0400
Date: Tue, 15 Aug 2006 00:48:39 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Rich Townsend <rhdt@bartol.udel.edu>
Cc: len.brown@intel.com, linux-acpi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: drivers/acpi/sbs.c:acpi_sbs_remove() inconsistent NULL checking
Message-ID: <20060814224839.GX3543@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Coverity checker spotted the following inconsistent NULL checking 
introduced by commit 3f86b83243d59bb50caf5938d284d22e10d082a4:

<--  snip  -->

...
int acpi_sbs_remove(struct acpi_device *device, int type)
{
        struct acpi_sbs *sbs = (struct acpi_sbs *)acpi_driver_data(device);
        int id;

        if (!device || !sbs) {
                return -EINVAL;
        }
...

<--  snip  -->

The NULL check for "device" is three lines after it got dereferenced the 
first time.

cu
Adrian

-- 

    Gentoo kernels are 42 times more popular than SUSE kernels among
    KLive users  (a service by SUSE contractor Andrea Arcangeli that
    gathers data about kernels from many users worldwide).

       There are three kinds of lies: Lies, Damn Lies, and Statistics.
                                                    Benjamin Disraeli

