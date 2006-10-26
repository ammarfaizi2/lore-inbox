Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423401AbWJZEtM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423401AbWJZEtM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 00:49:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423395AbWJZEtM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 00:49:12 -0400
Received: from rgminet01.oracle.com ([148.87.113.118]:28117 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1423401AbWJZEtL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 00:49:11 -0400
Message-ID: <45403E8C.80801@oracle.com>
Date: Wed, 25 Oct 2006 21:50:20 -0700
From: "Randy.Dunlap" <randy.dunlap@oracle.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: ankita@in.ibm.com
CC: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>
Subject: Re: [PATCH] lkdtm: cleanup headers and module_param/MODULE_PARM_DESC
References: <20061023200645.1657b7ab.randy.dunlap@oracle.com> <20061026041341.GA6562@in.ibm.com>
In-Reply-To: <20061026041341.GA6562@in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ankita Garg wrote:
> Hi,
> 
>>  #include <linux/kernel.h>
>> +#include <linux/fs.h>
>>  #include <linux/module.h>
>> +#include <linux/buffer_head.h>
>>  #include <linux/kprobes.h>
>> -#include <linux/kallsyms.h>
>> +#include <linux/list.h>
>>  #include <linux/init.h>
>> -#include <linux/irq.h>
>>  #include <linux/interrupt.h>
>> +#include <linux/hrtimer.h>
>>  #include <scsi/scsi_cmnd.h>
> 
> Why does the module require fs.h, hrtimer.h, list.h and buffer_head.h? It works fine for me without these header files. I do not get any gcc warning. Moreover, I found that even init.h and interrupt.h are also not required.

fs.h:  struct file *, struct block_device *
hrtimer.h:  struct hrtimer *
list.h:  struct list_head *
buffer_head.h:  struct buffer_head *

struct buffer_head is what triggered this.  gcc warns like this:

  CC [M]  drivers/misc/lkdtm.o
drivers/misc/lkdtm.c:150: warning: 'struct buffer_head' declared inside parameter list
drivers/misc/lkdtm.c:150: warning: its scope is only this definition or declaration, which is probably not what you want

or you could not #include those files and just do new source code lines like:

struct hrtimer;
struct buffer_head;
struct file;
struct block_dev;
struct list_head;

What we want to see is that source files explicly #include all header files
that they need or use, for structs, unions, extern data, function APIs, etc.
What is happening with lkdtm is that one or more header files is doing
this for you.  We want it to be more explicit than that.

-- 
~Randy
