Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270112AbSKED4h>; Mon, 4 Nov 2002 22:56:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277681AbSKED4h>; Mon, 4 Nov 2002 22:56:37 -0500
Received: from ausadmmsrr502.aus.amer.dell.com ([143.166.83.89]:11022 "HELO
	AUSADMMSRR502.aus.amer.dell.com") by vger.kernel.org with SMTP
	id <S270112AbSKED4e>; Mon, 4 Nov 2002 22:56:34 -0500
X-Server-Uuid: 586817ae-3c88-41be-85af-53e6e1fe1fc5
Message-ID: <20BF5713E14D5B48AA289F72BD372D68C1EAFE@AUSXMPC122.aus.amer.dell.com>
From: Matt_Domsch@Dell.com
To: mochel@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: RE: convert edd to use kobjects and sysfs.
Date: Mon, 4 Nov 2002 22:03:01 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
X-WSS-ID: 11D99D732180182-01-01
Content-Type: text/plain; 
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> ChangeSet 1.855.4.11, 2002/10/31 12:37:07-08:00, mochel@osdl.org
> 	convert edd to use kobjects and sysfs.

Pat, thanks for converting the EDD code to sysfs.  Is struct attribute going
to grow some form of existance test, something like I had done before?

> -static int
> -edd_populate_dir(struct edd_device *edev)
> -{
> -	struct edd_attribute *attr;
> -	int i;
> -	int error = 0;
> -
> -	for (i = 0; (attr=def_attrs[i]); i++) {
> -		if (!attr->test || (attr->test && !attr->test(edev))) {
> -			if ((error = edd_create_file(edev, attr))) {
> -				break;
> -			}
> -		}
> -	}

This allows attributes to be on def_attrs[] but depending on presence of
existance test (no test means true) and test result, not all attributes for
all similar objects get files created.  This cleanly handles cases where not
all attributes are implemented or valid for all objects of a given type, and
keeps the object's directory free of extraneous invalid files.

Thanks,
Matt


--
Matt Domsch
Sr. Software Engineer, Lead Engineer, Architect
Dell Linux Solutions www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com


