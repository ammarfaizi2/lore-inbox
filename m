Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262402AbTESX4J (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 19:56:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262316AbTESX4J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 19:56:09 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:37841 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262568AbTESX4G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 19:56:06 -0400
Date: Mon, 19 May 2003 17:10:52 -0700
From: Greg KH <greg@kroah.com>
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org, Patrick Mochel <mochel@osdl.org>
Subject: problem with sysfs symlink "fix"
Message-ID: <20030520001052.GA28067@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In the latest -bk tree sysfs's symlinks are a bit messed up:

$ tree /sys/bus/pci/
/sys/bus/pci/
|-- devices
|   |-- 00:00.0 -> ../../../
|   |-- 00:01.0 -> ../../../
|   |-- 00:1d.0 -> ../../../
|   |-- 00:1d.1 -> ../../../
|   |-- 00:1d.7 -> ../../../
|   |-- 00:1e.0 -> ../../../
|   |-- 00:1f.0 -> ../../../
|   |-- 00:1f.1 -> ../../../
|   |-- 00:1f.3 -> ../../../
|   |-- 00:1f.5 -> ../../../
|   |-- 02:03.0 -> ../../../    
|   |-- 02:04.0 -> ../../../    
|   `-- 02:05.0 -> ../../../    
`-- drivers                     
    |-- PIIX IDE                
    |   `-- 00:1f.1 -> ../../../../
    |-- aic7xxx                 
    |   `-- 02:05.0 -> ../../../../
    |-- eepro100                
    |-- ehci-hcd                
    |   `-- 00:1d.7 -> ../../../../
    |-- intel810_audio          
    |   `-- 00:1f.5 -> ../../../../
    |-- ohci-hcd
    |-- parport_pc
    |-- serial
    |-- tg3
    |   `-- 02:03.0 -> ../../../../
    `-- uhci-hcd
        |-- 00:1d.0 -> ../../../../
        `-- 00:1d.1 -> ../../../../


Could your fix to fs/sysfs/symlink.c have caused this?

thanks,

greg k-h
