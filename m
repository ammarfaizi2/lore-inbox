Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964997AbVKHDz7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964997AbVKHDz7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 22:55:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965259AbVKHDz7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 22:55:59 -0500
Received: from xenotime.net ([66.160.160.81]:7572 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S964997AbVKHDz7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 22:55:59 -0500
Date: Mon, 7 Nov 2005 19:40:44 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Martin Waitz <tali@admingilde.org>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch 1/4] DocBook: allow to mark structure members private
Message-Id: <20051107194044.1841277b.rdunlap@xenotime.net>
In-Reply-To: <20051107225604.841433000@admingilde.org>
References: <20051107225408.911193000@admingilde.org>
	<20051107225604.841433000@admingilde.org>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 07 Nov 2005 23:54:10 +0100 Martin Waitz wrote:

> DocBook: allow to mark structure members private
> 
> Many structures contain both an internal part and one which is part of the
> API to other modules.  With this patch it is possible to only include
> these public members in the kernel documentation.
> 
> Signed-off-by: Martin Waitz <tali@admingilde.org>


Ahoy.  Excellent.  Compare my personal todo list item:

35.for kernel-doc: make some fields :private: so that a description is not
    expected for them.


Just to be clear about the usage, the kernel-doc script switches from
public to private upon seeing a /*-style comment with the strings
"private:" or "public:" in it.  Right?

Yes, a lot of those USB header fields did need some help.
That's why my todo item was there.


> ---
>  include/linux/usb.h |    6 +++---
>  scripts/kernel-doc  |   13 +++++++++++--
>  2 files changed, 14 insertions(+), 5 deletions(-)
> 
> Index: linux-docbook/scripts/kernel-doc
> ===================================================================
> --- linux-docbook.orig/scripts/kernel-doc	2005-11-04 22:55:27.236188385 +0100
> +++ linux-docbook/scripts/kernel-doc	2005-11-04 23:13:29.348626536 +0100
> @@ -1304,6 +1306,12 @@ sub dump_struct($$) {
>  	# ignore embedded structs or unions
>  	$members =~ s/{.*?}//g;
>  
> +	# ignore members marked private:
> +	$members =~ s/\/\*.*?private:.*?public:.*?\*\///gos;
> +	$members =~ s/\/\*.*?private:.*//gos;
> +	# strip comments:
> +	$members =~ s/\/\*.*?\*\///gos;
> +
>  	create_parameterlist($members, ';', $file);
>  
>  	output_declaration($declaration_name,
> Index: linux-docbook/include/linux/usb.h
> ===================================================================
> --- linux-docbook.orig/include/linux/usb.h	2005-11-04 22:57:57.356783495 +0100
> +++ linux-docbook/include/linux/usb.h	2005-11-04 23:14:05.326614355 +0100
> @@ -819,7 +819,7 @@ typedef void (*usb_complete_t)(struct ur
>   */
>  struct urb
>  {
> -	/* private, usb core and host controller only fields in the urb */
> +	/* private: usb core and host controller only fields in the urb */
>  	struct kref kref;		/* reference count of the URB */
>  	spinlock_t lock;		/* lock for the URB */
>  	void *hcpriv;			/* private data for host controller */
> @@ -827,7 +827,7 @@ struct urb
>  	atomic_t use_count;		/* concurrent submissions counter */
>  	u8 reject;			/* submissions will fail */
>  
> -	/* public, documented fields in the urb that can be used by drivers */
> +	/* public: documented fields in the urb that can be used by drivers */
>  	struct list_head urb_list;	/* list head for use by the urb's
>  					 * current owner */
>  	struct usb_device *dev; 	/* (in) pointer to associated device */
> @@ -1045,7 +1045,7 @@ struct usb_sg_request {
>  	size_t			bytes;
>  
>  	/* 
> -	 * members below are private to usbcore,
> +	 * members below are private: to usbcore,
>  	 * and are not provided for driver access!
>  	 */
>  	spinlock_t		lock;
> 
> --


---
~Randy
