Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129161AbRCFOfn>; Tue, 6 Mar 2001 09:35:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129164AbRCFOfe>; Tue, 6 Mar 2001 09:35:34 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:47590 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S129161AbRCFOfX>; Tue, 6 Mar 2001 09:35:23 -0500
Importance: Normal
Subject: [PATCH] Lanstreamer in kernel support
To: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.4a  July 24, 2000
Message-ID: <OF850AEE47.7AEEA8C4-ON85256A07.004F9AFE@raleigh.ibm.com>
From: "Mike Sullivan" <sullivam@us.ibm.com>
Date: Tue, 6 Mar 2001 08:35:02 -0600
X-MIMETrack: Serialize by Router on D04NM201/04/M/IBM(Release 5.0.6 |December 14, 2000) at
 03/06/2001 09:35:06 AM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a small patch that allows the lanstreamer to be built as an in
kernel device. This code
is already in the 2.2.x tree but was dropped somewhere along the way.

Mike Sullivan
IBM LTC (sullivam@us.ibm.com)
                                                                           
                                                                           
                                      --- linux/drivers/net/Space.c.orig   
                                      Wed Feb 28 15:03:01 2001             
                                      +++ linux/drivers/net/Space.c Wed    
                                      Feb 28 15:03:35 2001                 
                                      @@ -545,6 +545,7 @@                  
                                       /* Token-ring device probe */       
                                       extern int ibmtr_probe(struct       
                                      net_device *);                       
                                       extern int olympic_probe(struct     
                                      net_device *);                       
                                      +extern int streamer_probe(struct    
                                      net_device *);                       
                                       extern int smctr_probe(struct       
                                      net_device *);                       
                                                                           
                                       static int                          
                                      @@ -556,6 +557,9 @@                  
                                       #endif                              
                                       #ifdef CONFIG_IBMOL                 
                                           && olympic_probe(dev)           
                                      +#endif                              
                                      +#ifdef CONFIG_IBMLS                 
                                      +    && streamer_probe(dev)          
                                       #endif                              
                                       #ifdef CONFIG_SMCTR                 
                                           && smctr_probe(dev)             
                                      ---                                  
                                      linux/drivers/net/tokenring/lanstrea 
                                      mer.c.orig     Thu Mar  1 10:08:49   
                                      2001                                 
                                      +++                                  
                                      linux/drivers/net/tokenring/lanstrea 
                                      mer.c     Thu Mar  1 10:08:56 2001   
                                      @@ -125,6 +125,13 @@                 
                                                                           
                                       static char *version                
                                      = "LanStreamer.c v0.3.1 03/13/99 -   
                                      Mike Sullivan";                      
                                                                           
                                      +static struct pci_device_id         
                                      streamer_pci_tbl[] __initdata = {    
                                      +    { PCI_VENDOR_ID_IBM,            
                                      PCI_DEVICE_ID_IBM_TR, PCI_ANY_ID,    
                                      PCI_ANY_ID,},                        
                                      +    {}   /* terminating entry */    
                                      +};                                  
                                      +MODULE_DEVICE_TABLE(pci,streamer_pc 
                                      i_tbl);                              
                                      +                                    
                                      +                                    
                                       static char *open_maj_error[] = {   
                                           "No error", "Lobe Media Test",  
                                      "Physical Insertion",                
                                           "Address Verification",         
                                      "Neighbor Notification (Ring Poll)", 
                                                                           
                                                                           





