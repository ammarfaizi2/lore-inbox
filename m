Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932789AbWKMSuM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932789AbWKMSuM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 13:50:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932785AbWKMSuM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 13:50:12 -0500
Received: from iriserv.iradimed.com ([69.44.168.233]:53280 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S932766AbWKMSuK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 13:50:10 -0500
Message-ID: <4558BE57.4020700@cfl.rr.com>
Date: Mon, 13 Nov 2006 13:49:59 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
MIME-Version: 1.0
To: Mathieu Fluhr <mfluhr@nero.com>
CC: jgarzik@pobox.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: READ SCSI cmd seems to fail on SATA optical devices...
References: <1163434776.2984.21.camel@de-c-l-110.nero-de.internal>
In-Reply-To: <1163434776.2984.21.camel@de-c-l-110.nero-de.internal>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 Nov 2006 18:50:18.0668 (UTC) FILETIME=[9085BEC0:01C70754]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.6.1039-14810.003
X-TM-AS-Result: No--10.592200-5.000000-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mathieu Fluhr wrote:
> Hello,
> 
> I recently tried to burn some datas on CDs and DVD using a SATA burner
> and the latest 2.6.18.2 kernel... using NeroLINUX. (It is controlling
> the device by sending SCSI commands over the 'sg' driver)
> 

Please note that the sg interface is depreciated.  It is now recommended 
that you send the CCBs directly to the normal device, i.e. /dev/hdc.

> The burn process works like a charm, no problems at all. But it seems
> that there are some slight problems with the READ scsi cmd:
> Inside our software, we have a verification routine that will make a
> sector-by-sector verification to check that everything that has been
> written is OK.
> 
> The problem is that, on SATA devices controlled by libata, on some big
> files (like for example a 600 MB file) the READ command seems to fail
> and outputs garbage (not 1 or 2 bytes diff, but the whole buffer).
>  -> This problem does not come out everytime, and each time on    
>     different sectors.
> 

I'm not sure what you mean by "on some big files" as the sg interface 
has no notion of files; you're just reading the disk sector by sector, 
as you said earlier.  Also by fail do you mean that the request returns 
an error status?  If so then the read buffer will not be valid.


