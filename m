Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291440AbSAaX6r>; Thu, 31 Jan 2002 18:58:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291443AbSAaX6j>; Thu, 31 Jan 2002 18:58:39 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:22259 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S291438AbSAaX6W>; Thu, 31 Jan 2002 18:58:22 -0500
Message-ID: <3C59DA19.5060403@us.ibm.com>
Date: Thu, 31 Jan 2002 15:58:17 -0800
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8+) Gecko/20020126
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Dan Maas <dmaas@dcine.com>, Ben Collins <bcollins@debian.org>
Subject: Revealing unload_lock to everyone
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This came up in a conversation about ieee1394_core.c.  In 2.5.3, the BKL 
is used to protect a module from being unloaded.  The code looks like this:

         lock_kernel();
         read_lock(&ieee1394_chardevs_lock);
         file_ops = ieee1394_chardevs[blocknum].file_ops;
         module = ieee1394_chardevs[blocknum].module;
         read_unlock(&ieee1394_chardevs_lock);
	...
         INCREF(module);
         unlock_kernel();
	

The question is, how can we keep the module from being unloaded between 
the file_ops assignment, and the INCREF.  Do we have a general purpose 
way, other than the BKL, to keep a module from being unloaded?  There is 
unload_lock, but it is static to module.c.  We can always make it 
global, but is there a better solution?

-- 
Dave Hansen
haveblue@us.ibm.com

