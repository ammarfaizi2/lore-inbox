Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754625AbWKMPEk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754625AbWKMPEk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 10:04:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754879AbWKMPEk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 10:04:40 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:1251 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1754625AbWKMPEj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 10:04:39 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XY6njGpePEQ48pD9gSAUA8QGhekF3jEiuDdIlwPHNwjpSHgBGkGh5Zss17rtb82+scUx6SqcmlHzD8fJOj+wCsUu2f/W4RkRzdlnobiG7mdBXDYlBOQAM5uy45OQAXQQSSfVGKY9l0AyS3TnIqhh0g+4vvMhw1JF+cWwloB9xUc=
Message-ID: <d120d5000611130704r258c8946p3994c5ba1e0187e9@mail.gmail.com>
Date: Mon, 13 Nov 2006 10:04:37 -0500
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: "Stelian Pop" <stelian@popies.net>
Subject: Re: [PATCH] Apple Motion Sensor driver
Cc: "Andrew Morton" <akpm@osdl.org>,
       "Michael Hanselmann" <linux-kernel@hansmi.ch>,
       "Aristeu S. Rozanski F." <aris@cathedrallabs.org>,
       "Johannes Berg" <johannes@sipsolutions.net>,
       "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
       "Paul Mackerras" <paulus@samba.org>, "Robert Love" <rml@novell.com>,
       "Jean Delvare" <khali@linux-fr.org>,
       "Rene Nussbaumer" <linux-kernel@killerfox.forkbomb.ch>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
In-Reply-To: <1163280972.32084.13.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1163280972.32084.13.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stelian,

On 11/11/06, Stelian Pop <stelian@popies.net> wrote:

 +
> +       if (input_register_device(ams_info.idev)) {
> +               input_free_device(ams_info.idev);
> +               ams_info.idev = NULL;
> +               return;
> +       }
> +
> +       ams_info.kthread = kthread_run(ams_mouse_kthread, NULL, "kams");
> +       if (IS_ERR(ams_info.kthread)) {
> +               input_unregister_device(ams_info.idev);
> +               ams_info.idev = NULL;
> +               return;
> +       }
> +}

Please consider implementing ams_mouse_start() and ams_mouse_stop()
methods for input_dev and start/stop polling thread there - there is
no reason to report input events when noone listens to them.

-- 
Dmitry
