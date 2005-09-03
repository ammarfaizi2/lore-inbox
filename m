Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751275AbVICW1Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751275AbVICW1Z (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 18:27:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751280AbVICW1Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 18:27:24 -0400
Received: from zproxy.gmail.com ([64.233.162.196]:53587 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751275AbVICW1Y convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 18:27:24 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=axySC+uEfjhsv3j5EZCgmVuc+1Z9F6m0yBmlMEJWkdUG6VZ6iktgsk8AytW5X2Z7IPTG2DGk7qCMZpUGrUWtnttAOSzINPPk9c6pQg/WzGIfyKG1PXsS9unBbIFiIW9Ao+WKN+d7Teb6OcwSn3580hUGJ9vFyQ1btWhNpRT/6aA=
Message-ID: <9a87484905090315273f9b7048@mail.gmail.com>
Date: Sun, 4 Sep 2005 00:27:20 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Harald Welte <laforge@gnumonks.org>
Subject: Re: [PATCH] New: Omnikey CardMan 4040 PCMCIA Driver
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <20050904110800.GN4415@rama.de.gnumonks.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050904101218.GM4415@rama.de.gnumonks.org>
	 <20050904110800.GN4415@rama.de.gnumonks.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/4/05, Harald Welte <laforge@gnumonks.org> wrote:
> On Sun, Sep 04, 2005 at 12:12:18PM +0200, Harald Welte wrote:
> > Hi!
> >
> > Below you can find a driver for the Omnikey CardMan 4040 PCMCIA
> > Smartcard Reader.
> 
> Sorry, the patch was missing a "cg-add" of the header file.  Please use
> the patch below.

It would be so much nicer if the patch actually was "below" - that is
"inline in the email as opposed to as an attachment". Having to first
save an attachment and then cut'n'paste from it is a pain.

Anyway, a few comments below :

+#define DEBUG(n, x, args...) do { if (pc_debug >= (n)) 			    \


line longer than 80 chars. Please adhere to CodingStyle and keep lines
<80 chars.
There's more than one occourance of this.

+static inline int cmx_waitForBulkOutReady(reader_dev_t *dev)


Why TheStudlyCaps ?  Please keep function names lowercase. There are
more instances of this, only pointing out one.

+        register int i;

+	register int iobase = dev->link.io.BasePort1;


Please use only tabs for indentation (line 1 of the above is indented
with spaces).

+	for (i=0; i < POLL_LOOP_COUNT; i++) {


for (i = 0; i < POLL_LOOP_COUNT; i++) {

+        if (rc != 1)


Again spaces used for indentation, please fix all that up to use tabs.

+	unsigned long ulBytesToRead;


lowercase prefered also for variables.

+	for (i=0; i<5; i++) {


for (i = 0; i < 5; i++) {

+			DEBUG(5,"cmx_waitForBulkInReady rc=%.2x\n",rc);


Space after ","s please : DEBUG(5, "cmx_waitForBulkInReady rc=%.2x\n", rc);

+	ulMin = (count < (ulBytesToRead+5))?count:(ulBytesToRead+5);


needs spaces : 
ulMin = (count < (ulBytesToRead + 5)) ? count : (ulBytesToRead + 5);

+	reader_dev_t *dev=(reader_dev_t *)filp->private_data;


reader_dev_t *dev = (reader_dev_t *)filp->private_data;


+static int cmx_open (struct inode *inode, struct file *filp)


get rid of the space before the opening paren : 
static int cmx_open(struct inode *inode, struct file *filp)


+	for (rc = pcmcia_get_first_tuple(handle, &tuple);

+	     rc == CS_SUCCESS;

+	     rc = pcmcia_get_next_tuple(handle, &tuple)) {

...
+		if (parse.cftable_entry.io.nwin) {

+			link->io.BasePort1 = parse.cftable_entry.io.win[0].base;

+			link->io.NumPorts1 = parse.cftable_entry.io.win[0].len;

+			link->io.Attributes1 = IO_DATA_PATH_WIDTH_AUTO;

+			if(!(parse.cftable_entry.io.flags & CISTPL_IO_8BIT))

+				link->io.Attributes1 = IO_DATA_PATH_WIDTH_16;

...
+		}
+	}

How about not having to indent so deep by rewriting that as

	for (rc = pcmcia_get_first_tuple(handle, &tuple);
	     rc == CS_SUCCESS;
	     rc = pcmcia_get_next_tuple(handle, &tuple)) {
...
		if (!parse.cftable_entry.io.nwin)
			continue;

		link->io.BasePort1 = parse.cftable_entry.io.win[0].base;
		link->io.NumPorts1 = parse.cftable_entry.io.win[0].len;
		link->io.Attributes1 = IO_DATA_PATH_WIDTH_AUTO;
		if(!(parse.cftable_entry.io.flags & CISTPL_IO_8BIT))
			link->io.Attributes1 = IO_DATA_PATH_WIDTH_16;
...
	}


+        link->conf.IntType = 00000002;


more spaces used for indentation. Not going to point out any more of these.

+	cmx_poll_timer.function = &cmx_do_poll;


shouldn't this be 
	 cmx_poll_timer.function = cmx_do_poll;
???

+	int i;

+	DEBUG(3, "-> reader_detach(link=%p\n", link);


please have a blank line between variable declarations and other statements.



-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
