Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274746AbRJJEu5>; Wed, 10 Oct 2001 00:50:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274752AbRJJEur>; Wed, 10 Oct 2001 00:50:47 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:36711 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S274749AbRJJEuk>; Wed, 10 Oct 2001 00:50:40 -0400
Date: Wed, 10 Oct 2001 00:51:12 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200110100451.f9A4pCW10769@devserv.devel.redhat.com>
To: paul.thacker@st.com, linux-kernel@vger.kernel.org
Subject: Re: usb_bulk_msg timeout w/ rvmalloc
In-Reply-To: <mailman.1002674521.5223.linux-kernel2news@redhat.com>
In-Reply-To: <mailman.1002674521.5223.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>      I have written a driver which, in part, facilitates the usb bulk 
>      transfer of raw image data. It works fine for small (CIF, QCIF) 
>      images, but for larger images, kmalloc will not allocate enough 
>      memory. 

How much do you need?
     
>      I copied the rvmalloc code from the cpia2 driver and used it in place 
>      of kmalloc. The memory allocates fine, but usb_bulk_msg now times out 
>      when using the pointer to the rvmalloc'd memory. I have been unable to 
>      find an instance of an existing driver using rvmalloc in conjunction 
>      with usb_bulk_msg. 

The best thing would be to use pipelined transfer with
several URBs, I think. If that is too difficult for you,
try to use __get_free_pages(), but mind that even if free
RAM is available, kernel may not be able to fulfill your
request. Check response codes carefuly.

-- Pete
