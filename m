Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263968AbTI2RlO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 13:41:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263953AbTI2RiG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 13:38:06 -0400
Received: from imr2.ericy.com ([198.24.6.3]:31677 "EHLO imr2.ericy.com")
	by vger.kernel.org with ESMTP id S263927AbTI2RfQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 13:35:16 -0400
Message-ID: <3F786E73.6010306@ericsson.ca>
Date: Mon, 29 Sep 2003 13:40:03 -0400
From: Jean-Guillaume <jean-guillaume.paradis@ericsson.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030903 Thunderbird/0.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Simple Procfs question: Triggering an "action" when opening a directory
 instead of a file (with seqfile.h)???
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everybody :)

I need some help on this one, I couldn't find anything on google or in 
the archives of the mailing list. Here it goes:

I want to trigger an action when "opening" a directory of the procfs. 
This is easy for files, but how is it done for directories...???

With files this is simple, all we have to do is to change some structs:

static struct file_operations FILE_fops = {
    open:        FILE_open,
    read:        seq_read,
    llseek:        seq_lseek,
    release:    seq_release,
};
and
static struct seq_operations FILE_ops = {
    start:    FILE_start,
    next:    FILE_next,
    stop:    FILE_stop,
    show:    FILE_show
};
and insert some code.


But for directories, the same doesn't work:

tipcDir  = proc_mkdir("tipc",&proc_root);
   if (tipcDir) {
      tipcDir->proc_fops = &tipcDir_fops;
   }

...

because when tyring to enter the directory of tipcDir, it says "tipc not 
a directory", probably because I try to use a "fops" (file operation). 
But I can't find any other ways to do this

Any ideas?
