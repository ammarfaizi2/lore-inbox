Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261213AbVCNG7M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261213AbVCNG7M (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 01:59:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261210AbVCNG7M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 01:59:12 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:46486 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261213AbVCNGz7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 01:55:59 -0500
Subject: Re: [CIFS] Add support for updating Windows NT times/dates (part 1)
From: Arjan van de Ven <arjan@infradead.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: sfrench@us.ibm.com
In-Reply-To: <200503132310.j2DNAWEv002812@hera.kernel.org>
References: <200503132310.j2DNAWEv002812@hera.kernel.org>
Content-Type: text/plain
Date: Mon, 14 Mar 2005 07:55:54 +0100
Message-Id: <1110783354.6288.33.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 4.1 (++++)
X-Spam-Report: SpamAssassin version 2.63 on pentafluge.infradead.org summary:
	Content analysis details:   (4.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.3 RCVD_NUMERIC_HELO      Received: contains a numeric HELO
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-01-26 at 23:30 +0000, Linux Kernel Mailing List wrote:
> ChangeSet 1.1966.1.22, 2005/01/26 17:30:51-06:00, stevef@stevef95.austin.ibm.com
> 
> 	[CIFS] Add support for updating Windows NT times/dates (part 1)
> 	
> 	Signed-off-by: Steve French (sfrench@us.ibm.com)
> 
> 
> 
>  cifspdu.h |   35 +++++++++++++++++++++++++----------
>  cifssmb.c |    9 ++++++---
>  inode.c   |   11 +++++------
>  3 files changed, 36 insertions(+), 19 deletions(-)
> 
> 
> diff -Nru a/fs/cifs/cifspdu.h b/fs/cifs/cifspdu.h
> --- a/fs/cifs/cifspdu.h	2005-03-13 15:10:44 -08:00
> +++ b/fs/cifs/cifspdu.h	2005-03-13 15:10:44 -08:00
> @@ -1592,17 +1592,32 @@
>  	char LinkDest[1];
>  } FILE_UNIX_LINK_INFO;		/* level 0x201 QPathInfo */
>  
> +/* The following three structures are needed only for
> +	setting time to NT4 and some older servers via
> +	the primitive DOS time format */
>  typedef struct {
> -	__u16 CreationDate;
> -	__u16 CreationTime;
> -	__u16 LastAccessDate;
> -	__u16 LastAccessTime;
> -	__u16 LastWriteDate;
> -	__u16 LastWriteTime;
> -	__u32 DataSize; /* File Size (EOF) */
> -	__u32 AllocationSize;
> -	__u16 Attributes; /* verify not u32 */
> -	__u32 EASize;
> +	__u16 Day:5;
> +	__u16 Month:4;
> +	__u16 Year:7;
> +} SMB_DATE;
> +

if this is an on the wire format (and it looks like one) then you want
this one packed I suspect, and also I wonder if it needs to be byte
order specific...

