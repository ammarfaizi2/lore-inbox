Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316322AbSFZDFo>; Tue, 25 Jun 2002 23:05:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316339AbSFZDFo>; Tue, 25 Jun 2002 23:05:44 -0400
Received: from rrcs-sw-24-153-135-82.biz.rr.com ([24.153.135.82]:43689 "HELO
	UberGeek") by vger.kernel.org with SMTP id <S316322AbSFZDFn>;
	Tue, 25 Jun 2002 23:05:43 -0400
Subject: Re: Urgent, Please respond - Re: max_scsi_luns and 2.4.19-pre10.
From: Austin Gonyou <austin@digitalroadkill.net>
To: jw schultz <jw@pegasys.ws>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020625194806.C26789@pegasys.ws>
References: <1025052385.19462.5.camel@UberGeek>
	 <1025056235.19779.4.camel@UberGeek>  <20020625194806.C26789@pegasys.ws>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
X-Mailer: Ximian Evolution 1.1.0.99 (Preview Release)
Date: 25 Jun 2002 22:05:39 -0500
Message-Id: <1025060739.20340.6.camel@UberGeek>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-06-25 at 21:48, jw schultz wrote:
> I'm no expert on this bit but look in
> drivers/scsi/scsi_scan.c for CONFIG_SCSI_MULTI_LUN 
> 
> #ifdef CONFIG_SCSI_MULTI_LUN
> static int max_scsi_luns = 8;
> #else
> static int max_scsi_luns = 1;
> #endif

This is, but there seems to be something more fundamental here. I'm
using the -aa patches, and the static int max_scsi_luns = 8; is actually
static int max_scsi_luns = MAX_SCSI_LUNS;

where above is: #define MAX_SCSI_LUNS 0xFFFFFFFF; 
but I'm not sure if this syntax is 0xFFFFFFFF == 8 or 2^n. 

To me, it seems like 8. I'm using pre10-aa2, I'm going to try pre10-aa4
as well, but if I must I'm going to hard-code the kernel bits I need I
supposed to make static int max_scsi_luns = MAX_SCSI_LUNS; into static
int max_scsi_luns = 16; to ensure it works at the level I need. 



> This is the variable you seem to want.
> 
> Note to SCSI maintainers.  a quick vi `grep -l CONFIG_SCSI_MULTI_LUN`
> here reveals lots of hardcoded values of 8.  It seems to me
> that perhaps a CONFIG_SCSI_MAX_LUN to replace
> CONFIG_SCSI_MULTI_LUN would be in order.

Agreed. I've always wondered why one cannot set this by hand, or even
simpler perhaps is a CONFIG_SCSI_MAX_LUN where values are set to one of
small, medium, large?

Thanks much J.W.

> ________________________________________________________________
> 	J.W. Schultz            Pegasystems Technologies
> 	email address:		jw@pegasys.ws
> 
> 		Remember Cernan and Schmitt
-- 
Austin Gonyou <austin@digitalroadkill.net>
