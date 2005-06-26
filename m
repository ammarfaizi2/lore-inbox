Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261527AbVFZS6j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261527AbVFZS6j (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 14:58:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261553AbVFZS6f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 14:58:35 -0400
Received: from rproxy.gmail.com ([64.233.170.195]:50931 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261527AbVFZS6b convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 14:58:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RocyJ29wu8QOe8gfF1FZgrFoDyz6JWRDhMs3xgobbsr+iSru0kslY+geepTJ61E8+ve8V2umFb4+f7eG8oqr7sgZryxJGpKklPHeyLeCB6ufCiDr2IZjZrmRgNL3MZLOM+G+/zUIAdkQTMyzTXNRDCM8wJsnj4HbNTW7BUnPlYg=
Message-ID: <4d8e3fd305062611586bda6c30@mail.gmail.com>
Date: Sun, 26 Jun 2005 20:58:30 +0200
From: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Reply-To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
To: Christian Kujau <evil@g-house.de>
Subject: Re: [ANNOUNCE] ORT - Oops Reporting Tool
Cc: =?ISO-8859-2?Q?Micha=B3_Piotrowski?= <piotrowskim@trex.wsi.edu.pl>,
       linux-kernel@vger.kernel.org
In-Reply-To: <42BDD3FC.8090706@g-house.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <42BBE593.9090407@trex.wsi.edu.pl> <42BC0DCD.8020206@g-house.de>
	 <4d8e3fd3050624085929581341@mail.gmail.com>
	 <42BDD3FC.8090706@g-house.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2005/6/26, Christian Kujau <evil@g-house.de>:
> Paolo Ciarrocchi wrote:
> >
> > The commands that are requiring root capabilties are:
> > lspci -vvv
> > lsusb -v
> 
> i still dislike the idea being forced to be root, does the attached patch
> looks ok?

Just for my understanding, why do you dislike to be forced to be root ?
You are reporting a kernel problem, I don't see any problem in being
root, but I donìt have a clear understing of pro and cons.

> --- ort/ort.sh.orig     2005-06-25 23:42:22.000000000 +0200
> +++ ort/ort.sh  2005-06-25 23:54:32.000000000 +0200
> @@ -34,7 +34,6 @@ EM_CLI=mutt
> 
> help() {
>     echo "Usage: [root@mylinuxbox ~]$ ./ort.sh oops.txt"
> -    echo "You need to be root [uid=0] to run the script"
>     exit 1
> }
> 
> @@ -53,7 +52,12 @@ cmd_line() {
> check_uid() {
>     if [ $UID != "0" ]
>        then
> -           help
> +           echo -n "You should be root [uid=0] to run the script, continue? [y,n]  "
> +           read c
> +           if [ "$c" != "y" ]; then
> +               echo "Aborted."
> +               exit 1
> +           fi
>     fi
> }

This is fine with me.
 
> @@ -274,7 +278,7 @@ point_7_4() {
> 
> point_7_5() {
>     echo -e "\n[7.5.] PCI information" >> $ORT_F
> -    lspci -vvv >> $ORT_F
> +    env PATH=/bin:/usr/bin:/sbin:/usr/sbin lspci -vvv >> $ORT_F

What's the benefit of this change ?

> }
> 
> point_7_6() {
> @@ -286,7 +290,7 @@ point_7_6() {
> 
> point_7_7() {
>     echo -e "\n[7.7.] USB information" >> $ORT_F
> -    lsusb -v >> $ORT_F
> +    env PATH=/bin:/usr/bin:/sbin:/usr/sbin lsusb -v >> $ORT_F
> }
> 
> point_7_8() {
> 
> 


-- 
Paolo
