Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751035AbWJCXto@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751035AbWJCXto (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 19:49:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932285AbWJCXtn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 19:49:43 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:58121 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751026AbWJCXtm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 19:49:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VQqZREgjoYI6xMxAjck/sdKdxhidXp0AmSX8oFEe1OP3560qCi8v5ZYzwgCIWTosXkvjDk//Ky0u/RsEAYbr7tVWx5OPfAZphYM0FxSOh/UXz7dNn9Xp4dBp868gwWBqtl0qpi8MYi2MYT+Gwi8uUkKn1tKh4iz8m2XpO5x1WXY=
Message-ID: <41840b750610031649n5db15a0bq4834420b51974562@mail.gmail.com>
Date: Wed, 4 Oct 2006 01:49:41 +0200
From: "Shem Multinymous" <multinymous@gmail.com>
To: "Kristen Carlson Accardi" <kristen.c.accardi@intel.com>
Subject: Re: [patch 2/2]: acpi: add removable drive bay support
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
       len.brown@intel.com
In-Reply-To: <20060907161319.5495fc65.kristen.c.accardi@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060907161319.5495fc65.kristen.c.accardi@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kristen,

On 9/8/06, Kristen Carlson Accardi <kristen.c.accardi@intel.com> wrote:

> +static void bay_notify(acpi_handle handle, u32 event, void *data)
[...]
> +       case ACPI_NOTIFY_EJECT_REQUEST:
[...]
> +               /* wouldn't it be a good idea to just call the
> +                * eject_device here if we were a SATA device?
> +                */

No, bay eject should go through userspace so that it gets a chance to
do cleanup (e.g., unmount filesystems) or to tell the user to abort
the eject (e.g., filesystems in use, or system running on bay battery
power).

And the driver of whatever is in the bay should be informed before
power is removed so it can do its own cleanup (e.g., spin down disk).
This can also be done by userspace.

So your current code is fine, and the comment should probably be
removed lest someone tries to follow it.

  Shem
