Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261993AbTD2HUD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Apr 2003 03:20:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261995AbTD2HUD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Apr 2003 03:20:03 -0400
Received: from f78.law10.hotmail.com ([64.4.15.78]:53259 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id S261993AbTD2HUB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Apr 2003 03:20:01 -0400
X-Originating-IP: [12.210.22.14]
X-Originating-Email: [bobbysingh22@hotmail.com]
From: "Bobby Singh" <bobbysingh22@hotmail.com>
To: linux-kernel@vger.kernel.org
Cc: linux-aio@kvack.org
Subject: Having problem with io_getevents with o_direct flag
Date: Tue, 29 Apr 2003 00:32:13 -0700
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <Law10-F78IJsaJbqJGN00015519@hotmail.com>
X-OriginalArrivalTime: 29 Apr 2003 07:32:14.0394 (UTC) FILETIME=[7445B1A0:01C30E21]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

  I am having problems with using io_getevents ? Is the o_direct aio support 
stable in 2.5.67? Following is the scenario:

Machine: Dell 500SC 1.13Gz
Original Kernel : 2.4.18-3 ( redhat 7.3)
Downloaded kernel 2.5.67 and compiled it.
Installed libaio-0.3.92 aio library.

I am writing an io intensive application and want to leverage the o_direct 
aio support. I am using in following way (borrowed from testcase in libaio)

struct iocb **pAiocb;
struct io_event event;
if(io_submit(io_ctx,numAiocb, pAiocb) <0)
{
    perror("Error in io_submit");
    return(-1);
}
for(i=0;i<numAiocb;i++)
{
    if((res=io_getevents(io_ctx,0,1,event,NULL)) && (res != 1))
    {
        perror("Error in getevents");
        return(-1);
    }
    printf("%d\n",event.res);
}


PROBLEM is : THe code doesn't print an ERROR but in "event.res" the amount 
of data  read is not same as requested. Sometimes the return size is ZERO 
and event is returned.

THE CODE WORKS fine if the file is opened WITHOUT O_DIRECT.

Thanks,
Bobby

_________________________________________________________________
Protect your PC - get McAfee.com VirusScan Online  
http://clinic.mcafee.com/clinic/ibuy/campaign.asp?cid=3963

