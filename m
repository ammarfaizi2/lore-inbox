Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261568AbSIXFXt>; Tue, 24 Sep 2002 01:23:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261570AbSIXFXt>; Tue, 24 Sep 2002 01:23:49 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:52234 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261568AbSIXFXs>;
	Tue, 24 Sep 2002 01:23:48 -0400
Message-ID: <3D8FF7FB.7020504@pobox.com>
Date: Tue, 24 Sep 2002 01:28:27 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Larry Kessler <kessler@us.ibm.com>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       cgl_discussion mailing list <cgl_discussion@osdl.org>,
       evlog mailing list <evlog-developers@lists.sourceforge.net>,
       Rusty Russell <rusty@rustcorp.com.au>, Hien Nguyen <hien@us.ibm.com>,
       James Keniston <kenistoj@us.ibm.com>,
       Mike Sullivan <sullivam@us.ibm.com>
Subject: Re: [PATCH-RFC] README 1ST - New problem logging macros (2.5.38)
References: <3D8FC601.80BAC684@us.ibm.com> <20020924051505.GA21499@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
>>The concept:
>>-----------
>>* Device Drivers use new macros to log "problems" when errors are
>>  detected.
> 
> 
> Nice concept.  But what's wrong with the existing method of logging when
> errors are detected?  Can you give us some background as to what is
> lacking in the current stuff?

Bah, who needs define a problem when you have a sexy solution...
</sarcasm>


>>If event logging is configured....
>>
>>* During the build process
>>  the static details (textual description, problem attribute names,
>>  format specifiers for problem attributes, source file name, function
>>  name and line number) associated with the problem() and introduce()
>>  calls are stored in a .log section in the .o file. 
> 
> 
> Nice.

indeed


>>(3) 'make templates' extracts this data from the disk_dummy.o file and
>>    generates a formatting template in templates/disk_dummy/disk_dummy.t:
>>
>>      facility "disk_dummy";
>>      event_type 0x8ab218f4; /* file, message */

I don't see why we need a "make templates" at all in the kernel tarball. 
  This can be totally external to the kernel and still work fine.


>>(4)  'make templates_install' copies disk_dummy/disk_dummy.t to 
>>     /var/evlog/templates.  

If they are compiled into the kernel and modules, this is not needed in 
the kernel tarball either.

It should be straightforward to [re-]generate templates on boot, much 
like module dependencies are [re-]computed on boot when necessary.



>>Notes:
>>-----
>>For the following 3 invocations, the first 2 work, the 3rd does not...
>>
>>problem(LOG_ALERT, "Disk on fire");    // OK
>>
>>#define DISK_ON_FIRE "Disk on fire"
>>problem(LOG_ALERT, DISK_ON_FIRE);     // OK
>>
>>msg = "Disk on fire";
>>problem(LOG_ALERT, msg);  // No good
> 
> 
> Why does this not work?


doh!  I missed that.  That "no good" example is in use in the kernel 
today, implying that this new API reduces functionality...

	Jeff



