Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269211AbTGOR5X (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 13:57:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269225AbTGOR5G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 13:57:06 -0400
Received: from mail.kroah.org ([65.200.24.183]:54960 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S269211AbTGORwc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 13:52:32 -0400
Date: Tue, 15 Jul 2003 11:07:32 -0700
From: Greg KH <greg@kroah.com>
To: ffrederick@prov-liege.be
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipc kobject model against 2.6t1
Message-ID: <20030715180732.GB4495@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some coding style issues:


> +/*
> + * sysfs exports
> + */
> +
> +#define SHM_ATTR(_ind, _name)\
> +		shm_ids.entries[id].sysfs_attr[_ind].name=(char*)kmalloc(SYSFS_ATTR_MAX_LENGTH,GFP_KERNEL); \
> +		sprintf(shm_ids.entries[id].sysfs_attr[_ind].name,__stringify(_name)); \
> +		shm_ids.entries[id].sysfs_attr[_ind].mode=0644; \
> +		sysfs_create_file(&shm_ids.entries[id].kobj, &shm_ids.entries[id].sysfs_attr[_ind]); 

At least _try_ to get within 80 columns :)

> +static ssize_t shm_attr_show(struct kobject *kobj, struct attribute *attr, char *buf){

Put '{' on the new line, as Documentation/CodingStyle states to.

> +	unsigned long key=simple_strtoul(kobj->name,NULL,10);
> +	unsigned int id=0;
> +	int found=0;
> +	struct shmid_kernel *shp;
> +	for(id=0;id<=shm_ids.max_id&&!found;id++){

Add an empty line between the variables being defined, and the first
function statement.

Add some spaces in the for() line to look like:
	for (id=0; id<=shm_ids.max_id && !found; id++) {

Same thing for your if () statements:


> +	if(found){


>  void __init shm_init (void)
>  {
>  	ipc_init_ids(&shm_ids, 1);
>  #ifdef CONFIG_PROC_FS
>  	create_proc_read_entry("sysvipc/shm", 0, 0, sysvipc_shm_read_proc, NULL);
>  #endif
> +        strcpy(shm_ids.kobj.name, "shm");
> +        //shm_ids.kobj.parent = &ipc_kobj;	
> +	shm_ids.kobj.parent = NULL;
> +        kobject_register(&shm_ids.kobj);

Use tabs, and not spaces.

> @@ -266,7 +345,6 @@
>  		shm_unlock(shp);
>  	}
>  	up(&shm_ids.sem);
> -
>  	return err;
>  }

Was removing that line really necessary :)


> @@ -274,6 +283,7 @@
>  		vfree(ptr);
>  	else
>  		kfree(ptr);
> +
>  }

You added that line why?  :)

Hope this helps,

greg k-h
