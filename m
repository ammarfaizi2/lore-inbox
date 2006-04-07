Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964809AbWDGPmL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964809AbWDGPmL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 11:42:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964812AbWDGPmL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 11:42:11 -0400
Received: from wproxy.gmail.com ([64.233.184.225]:34227 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964809AbWDGPmK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 11:42:10 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=pZRtj5nJs/l/brwHLd3YvdNzE1viuod2/2QDyVpJbuG9bckuHFAoCVXE1SRZdWAqdk5Xr+GPjb6up1wQSJKnNeKZWBg2IZCWBNiqP+/8xpe5Zx4jNcxAQ54AJ644yMvT9mqUv31uT2hduo4T/jDgrTFDTehMfqA2u+rB5uR6TNg=
Message-ID: <4ae3c140604070842x537353c4s9a60706c2a2d25d9@mail.gmail.com>
Date: Fri, 7 Apr 2006 11:42:09 -0400
From: "Xin Zhao" <uszhaoxin@gmail.com>
To: linux-kernel <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org
Subject: How to know when file data has been flushed into disk?
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

If a program access data like this:

1. open the file
2. write a lot of data into this file
3. close the file

Assume the underlying file system is Ext3 file system.

If Ext3 is in the data=ordered	mode,	all data will be forced directly
out to the main file system prior to its metadata being committed to
the journal.

So my questions are:
1. How will the file system be notified after all data has been
flushed into disk?

2. Unlike data=journal mode, in data=order mode, the data could be
lost if system crashes when data is being flushed to disk. When system
reboots, does journal contains the old meta data for undo?

3. Does sys_close() have to  be blocked until all data and metadata
are committed? If not, sys_close() may give application an illusion
that the file is successfully written, which can cause the application
to take subsequent operation. However, data flush could be failed. In
this case, file system seems to mislead the application. Is this true?
If so, any solutions?

Thanks in advance for your help!

-x
