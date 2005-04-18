Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261696AbVDRGRi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261696AbVDRGRi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 02:17:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261745AbVDRGRi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 02:17:38 -0400
Received: from web54105.mail.yahoo.com ([206.190.37.240]:33161 "HELO
	web54105.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261696AbVDRGRY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 02:17:24 -0400
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=Y0j8tb1G12iI9/1qnDnJyyzk0vJkSujFNyuwVVoJRENFHraIzI9JA4102Fg2ujvLJgh5kNNtHQjdwti9RBB1kC4ew7GpCWz4TsL/zxJBpayzk5vVKX2M9t7v1RkXe4k64FPQ4wd3d4sAJCmSjQVMBOfHrAahizEtgOrNYO1nRhg=  ;
Message-ID: <20050418061723.49716.qmail@web54105.mail.yahoo.com>
Date: Sun, 17 Apr 2005 23:17:23 -0700 (PDT)
From: sai narasimhamurthy <sai_narasi@yahoo.com>
Subject: Re: increasing scsi_max_sg / max_segments for scsi writes/reads
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: 6667
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi , 
I tried working on scsi_malloc to increase burst size
, but to no avail ..all I got was hanged system every
time I started data transfers! 
Has anyone worked on scsi_malloc , I am still trying
to figure out what changes were made in 2.6 to
overcome this problem of limited bursts. 

Any pointers are very greatly welcome...I have never
worked on this part of the code before .


Sai










--- "Randy.Dunlap" <rddunlap@osdl.org> wrote:
> On Sat, 9 Apr 2005 19:35:52 -0700 (PDT) sai
> narasimhamurthy wrote:
> 
> | Hi, 
> | I had posted a question on increasing the scsi
> | read/write sectors  per command. I figured out
> some of
> | the things, but many questions still exist. 
> | 
> | I was wondering why the maximum writes I could get
> | from a single scsi write command could never
> exceed
> | 204 
> | 4096B  segments . I traced it to :  
> | 
> | static const int scsi_max_sg = PAGE_SIZE /
> | sizeof(struct scatterlist)
> | 
> | in scsi_merge.c .(which amounts to 204)  
> | 
> | Is this the limit of the maximum blocks we can
> | read/write through a single scsi command, atleast
> for
> | the given kernel (2.4.29) ? How can I increase
> | it??????
> | 
> | I am on a P3 Dell poweredgde 2400 . 
> 
> Did you read the comment immediately above that
> calculation?
> 
> /*
>  * scsi_malloc() can only dish out items of
> PAGE_SIZE or less, so we cannot
>  * build a request that requires an sg table
> allocation of more than that.
>  */
> 
> so scsi_malloc() would need some reworking to handle
> more.
> 
> OTOH, it appears that this is all removed in
> 2.6.10++, so moving to
> 2.6.recent is probably your best choice.
> 
> ---
> ~Randy
> -
> To unsubscribe from this list: send the line
> "unsubscribe linux-scsi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at 
> http://vger.kernel.org/majordomo-info.html
> 


		
__________________________________ 
Do you Yahoo!? 
Yahoo! Small Business - Try our new resources site!
http://smallbusiness.yahoo.com/resources/ 
