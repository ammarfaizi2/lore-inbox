Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030534AbVKPWZR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030534AbVKPWZR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 17:25:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030535AbVKPWZR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 17:25:17 -0500
Received: from ihemail1.lucent.com ([192.11.222.161]:9453 "EHLO
	ihemail1.lucent.com") by vger.kernel.org with ESMTP
	id S1030534AbVKPWZP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 17:25:15 -0500
Message-ID: <0C6AA2145B810F499C69B0947DC5078107BCDE20@oh0012exch001p.cb.lucent.com>
From: "Cipriani, Lawrence V (Larry)" <lvc@lucent.com>
To: "David S. Miller" <davem@davemloft.net>,
       "Cipriani, Lawrence V (Larry)" <lvc@lucent.com>
Cc: linux-kernel@vger.kernel.org
Subject: RE: bugs in /usr/src/linux/net/ipv6/mcast.c
Date: Wed, 16 Nov 2005 17:24:37 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks.  We're on 2.4.x  For what it's worth, here are a few more I found:

/usr/src/linux/drivers/sound/vidc.c: extra semicolon near line 227

for (new2size = 128; new2size < newsize; new2size <<= 1);  	!!!
        if (new2size - newsize > newsize - (new2size >> 1))
                new2size >>= 1;                            

-----------------------------------------------------------
/usr/src/linux/sound/drivers/serialmidi.c: extra semicolon near line 441

        if (serial->sdev);                             !!!
                kfree(serial->sdev);                   

-----------------------------------------------------------

/usr/src/linux/drivers/s390/misc/chandev.c: extra semicolon near line 2031

	if(chandev_find_eligible_channels(curr_chandev,
		&read_chandev,
		&write_chandev,
		&data_chandev,
		&next_chandev,
		curr_force->chan_type));			!!!
	{                                               

-----------------------------------------------------------

/usr/src/linux/drivers/s390/misc/chandev.c: extra semicolong near line 2150

while(!atomic_compare_and_swap(TRUE,FALSE,&chandev_new_msck));		!!!
{                                                             
        chandev_probe();                                      
}                                                             

-----------------------------------------------------------

/usr/src/linux/drivers/s390/block/dasd.c: extra semicolon near line 1528

		if (device->discipline->term_IO (cqr) != 0);  !!!
			cqr->status = CQR_STATUS_FAILED;

-----------------------------------------------------------

/usr/src/linux/drivers/scsi/ide-scsi.c: extra semicolon near line 855

	for (id = 0;
	        id < MAX_HWIFS*MAX_DRIVES && idescsi_drives[id];
	                    id++);		!!!
	        idescsi_setup(drive, scsi, id);

-----------------------------------------------------------
/usr/src/linux/drivers/scsi/osst.c: extra semicolon near line 5264

                for (nbr=0; osst_buffers[nbr] != STbuffer && nbr < osst_nbr_buffers; nbr++);   	!!!
                        printk(OSST_DEB_MSG
                           "osst :D: Expanded tape buffer %d (%d bytes, %d->%d segments, dma: %d, a: %p).\n",
                           nbr, got, STbuffer->orig_sg_segs, STbuffer->sg_segs, need_dma, STbuffer->b_data);
                        printk(OSST_DEB_MSG
                           "osst :D: segment sizes: first %d, last %d bytes.\n",
                           STbuffer->sg[0].length, STbuffer->sg[segs-1].length);

-----------------------------------------------------------

I'm not sure about this one, it sure looks hinky:

/usr/src/linux/abi/svr4/misc.c: extra semicolon near line 564:

for (p = tmp; *p; p++); 		!!!
        p--;            

might need to be:

for (p = tmp; *p; p++)
        p--;            

-----------------------------------------------------------

My C/C++ static analyzer reported several other things too, I'll send them in later.

Larry

-----Original Message-----
From: David S. Miller [mailto:davem@davemloft.net]
Sent: Wednesday, November 16, 2005 4:02 PM
To: lvc@lucent.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: bugs in /usr/src/linux/net/ipv6/mcast.c


From: "Cipriani, Lawrence V (Larry)" <lvc@lucent.com>
Date: Wed, 16 Nov 2005 09:53:07 -0500

> /usr/src/linux/net/ipv6/mcast.c: extra semicolon near line 609         
>                 if (mc->sfmode == MCAST_INCLUDE && i >= psl->sl_count);
>                         rv = 0;                                        
> should be:
> 		    if (mc->sfmode == MCAST_EXCLUDE && i >= psl->sl_count)
> 				rv = 0;
> 
> /usr/src/linux/net/ipv6/mcast.c: extra semicolon near line 611         
>                 if (mc->sfmode == MCAST_EXCLUDE && i < psl->sl_count); 
>                         rv = 0;                             
> should be:
> 		    if (mc->sfmode == MCAST_EXCLUDE && i < psl->sl_count)
> 				rv = 0;

These have been fixed for a while now in 2.6.x
