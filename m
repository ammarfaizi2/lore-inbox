Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316965AbSFZWDV>; Wed, 26 Jun 2002 18:03:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316981AbSFZWDU>; Wed, 26 Jun 2002 18:03:20 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:65034 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S316965AbSFZWDS>;
	Wed, 26 Jun 2002 18:03:18 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'devfs@oss.sgi.com'" <devfs@oss.sgi.com>
Subject: Re: Inexplicable disk activity trying to load modules on devfs 
In-reply-to: Your message of "Tue, 25 Jun 2002 23:38:48 -0400."
             <200206260338.g5Q3cmc19214@mobilix.ras.ucalgary.ca> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 27 Jun 2002 08:03:09 +1000
Message-ID: <19231.1025128989@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jun 2002 23:38:48 -0400, 
Richard Gooch <rgooch@ras.ucalgary.ca> wrote:
>Daniel Jacobowitz writes:
>> For the curious, the reason is that modprobe writes even failed
>> attempts to a log in /var/log/ksymoops, and calls fdatasync() on
>> that file afterwards.  There is no way to disable this without
>> removing that directory, as a design decision.  I don't personally
>> see the point in logging attempts which fail because there is no
>> driver...
>
>Sounds like the behaviour of modprobe needs to be fixed.

People wanted to know what was invoking modprobe and with what
parameters, especially for failed attempts.  The call to fdatasync() is
to "ensure" that the log data hits the disk _before_ the module is
loaded, otherwise debugging data is lost if the module init routine
oopses.

