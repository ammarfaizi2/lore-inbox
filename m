Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422823AbWAMS5r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422823AbWAMS5r (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 13:57:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422827AbWAMS5r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 13:57:47 -0500
Received: from liaag2ab.mx.compuserve.com ([149.174.40.153]:16615 "EHLO
	liaag2ab.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1422824AbWAMS5q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 13:57:46 -0500
Date: Fri, 13 Jan 2006 13:51:43 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: PROBLEM: Oops in Kernel 2.6.15 usbhid
To: Adrian Bunk <bunk@stusta.de>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-stable <stable@kernel.org>
Message-ID: <200601131354_MC3-1-B5D5-C29A@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <20060112011125.GO29663@stusta.de>

On Thu, 12 Jan 2006, Adrian Bunk wrote:

> On Wed, Jan 11, 2006 at 09:31:32AM -0500, Dmitry Torokhov wrote:
> > On 1/11/06, Patrick Read <pread99999@gmail.com> wrote:
> > > On 1/9/06, Dmitry Torokhov <dtor_core@ameritech.net> wrote:
> > > > ===================================================================
> > > > --- work.orig/drivers/usb/input/pid.c
> > > > +++ work/drivers/usb/input/pid.c
> > > > @@ -259,7 +259,7 @@ static int hid_pid_upload_effect(struct
> > > >  int hid_pid_init(struct hid_device *hid)
> > > >  {
> > > >         struct hid_ff_pid *private;
> > > > -       struct hid_input *hidinput = list_entry(&hid->inputs, struct hid_input, list);
> > > > +       struct hid_input *hidinput = list_entry(hid->inputs.next, struct hid_input, list);
> > > >         struct input_dev *input_dev = hidinput->input;
> > > >
> > > >         private = hid->ff_private = kzalloc(sizeof(struct hid_ff_pid), GFP_KERNEL);
> > > >
> > >
> > > The above fix works like a charm.  2.6.15 is running on this very
> > > computer that I'm typing on.
> > >
> > > Thank you for your good work.  Please ensure that this fix gets
> > > incorporated in the mainline kernel.
> > >
> > 
> > Thank you for testing it, I will forward it to Linus.
> 
> Could you also forward it stable@kernel.org for inclusion in 2.6.15.x?


I don't see it in Linus's tree yet.

Could it still be put into 2.6.15.1?

--

From: Dmitry Torokhov <dtor_core@ameritech.net>

Fix oops in usbhid.

--- work.orig/drivers/usb/input/pid.c
+++ work/drivers/usb/input/pid.c
@@ -259,7 +259,7 @@ static int hid_pid_upload_effect(struct 
 int hid_pid_init(struct hid_device *hid)
 {
 	struct hid_ff_pid *private;
-	struct hid_input *hidinput = list_entry(&hid->inputs, struct hid_input, list);
+	struct hid_input *hidinput = list_entry(hid->inputs.next, struct hid_input, list);
 	struct input_dev *input_dev = hidinput->input;
 
 	private = hid->ff_private = kzalloc(sizeof(struct hid_ff_pid), GFP_KERNEL);
-- 
Chuck
Currently reading: _Olympos_ by Dan Simmons
